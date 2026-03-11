import cv2
import numpy as np
from PIL import Image
from typing import List, Tuple, Optional, Dict
import io
import os

class OMRProcessor:
    """
    OMR bubble sheet processor optimized for standard grid-style answer sheets.
    
    Reference format:
      - 4 columns (A-D) of evenly spaced circles
      - Filled answer = solid black circle
      - Empty answer  = thin outline circle
      - Regular row spacing, question numbers on left
    
    Pipeline:
      1. Load & standardize image size
      2. CLAHE + bilateral filter (handles uneven phone-camera lighting)
      3. Perspective correction (straighten tilted sheets)
      4. Grid-aware bubble detection:
         a. Find ALL circles (filled + empty) via Hough + contour methods
         b. Cluster X positions → columns, Y positions → rows
         c. Validate grid geometry (expected N_questions × N_choices)
      5. Fill-ratio per bubble (dark-pixel ratio + intensity comparison)
      6. Per-row answer extraction with confidence scoring
    """

    def __init__(self, enable_auto_calibration: bool = True, debug: bool = False):
        self.debug = debug
        self.enable_auto_calibration = enable_auto_calibration
        
        # Detection thresholds
        self.fill_threshold_min = 0.06
        self.fill_threshold_high = 0.20
        self.gap_threshold = 0.03
        
        # Bubble geometry constraints (refined by auto-calibration)
        self.bubble_area_min = 80
        self.bubble_area_max = 20000
        self.bubble_circularity_min = 0.35
        self.bubble_aspect_ratio_range = (0.45, 2.0)
        
        # Preprocessing
        self.target_width = 1200
        self.clahe_clip = 2.5
        self.clahe_grid = (8, 8)
        
        # Debug output
        self.debug_dir = os.path.join(os.path.dirname(__file__), "debug_output")
        if self.debug and not os.path.exists(self.debug_dir):
            os.makedirs(self.debug_dir, exist_ok=True)

    # ════════════════════════════════════════════════════════════════════
    #  MAIN ENTRY POINT
    # ════════════════════════════════════════════════════════════════════

    def process_answer_sheet(self, image_data: bytes, answer_count: int = 20,
                             choices: List[str] = None) -> Tuple[List[Optional[str]], dict]:
        if choices is None:
            choices = ["A", "B", "C", "D"]
        num_choices = len(choices)
        
        try:
            # 1 ─ Load & standardize
            img = self._load_image(image_data)
            print(f"[OMR] Image loaded: {img.shape}")
            
            # 2 ─ Preprocess
            gray, enhanced = self._preprocess(img)
            
            # 3 ─ Align
            aligned_gray, aligned_color = self._align_sheet(gray, enhanced, img)
            print(f"[OMR] Aligned: {aligned_gray.shape}")
            
            # 4 ─ Find ALL circles (filled + empty)
            all_circles = self._find_all_circles(aligned_gray, aligned_color)
            print(f"[OMR] Found {len(all_circles)} circle candidates")
            
            if len(all_circles) < num_choices:
                return None, {"error": f"Only {len(all_circles)} circles found. "
                              "Ensure the sheet is clearly visible and well-lit."}
            
            # 5 ─ Build grid: cluster into columns & rows
            grid, grid_meta = self._build_grid(all_circles, num_choices, answer_count)
            print(f"[OMR] Grid: {len(grid)} rows  (expected {answer_count})")
            
            if not grid:
                # Fallback: use row-grouping without grid validation
                print("[OMR] Grid detection failed, falling back to row-clustering")
                grid, grid_meta = self._fallback_row_grouping(
                    all_circles, num_choices, answer_count)
            
            if not grid:
                return None, {"error": "Could not organize bubbles into a grid."}
            
            # 6 ─ Calculate fill ratio for every bubble in the grid
            dark_mask = self._get_dark_mask(aligned_gray)
            bubbles_data = self._fill_grid(grid, dark_mask, aligned_gray, choices)
            print(f"[OMR] Fill ratios computed for {len(bubbles_data)} questions")
            
            if not bubbles_data:
                return None, {"error": "Could not compute fill ratios."}
            
            # 7 ─ Extract answers
            answers, metadata = self._extract_answers(bubbles_data, answer_count)
            metadata["grid_info"] = grid_meta
            return answers, metadata
            
        except Exception as e:
            import traceback
            return None, {"error": str(e), "traceback": traceback.format_exc()}

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 1 – Load
    # ════════════════════════════════════════════════════════════════════

    def _load_image(self, data: bytes) -> np.ndarray:
        arr = np.frombuffer(data, np.uint8)
        img = cv2.imdecode(arr, cv2.IMREAD_COLOR)
        if img is None:
            raise ValueError("Invalid image data")
        h, w = img.shape[:2]
        if w != self.target_width:
            scale = self.target_width / w
            img = cv2.resize(img, (self.target_width, int(h * scale)),
                             interpolation=cv2.INTER_AREA if scale < 1 else cv2.INTER_LINEAR)
            print(f"[OMR] Resized {w}x{h} → {img.shape[1]}x{img.shape[0]}")
        return img

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 2 – Preprocess (CLAHE)
    # ════════════════════════════════════════════════════════════════════

    def _preprocess(self, img: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        clahe = cv2.createCLAHE(clipLimit=self.clahe_clip, tileGridSize=self.clahe_grid)
        enhanced = clahe.apply(gray)
        enhanced = cv2.bilateralFilter(enhanced, 9, 75, 75)
        if self.debug:
            cv2.imwrite(os.path.join(self.debug_dir, "01_gray.png"), gray)
            cv2.imwrite(os.path.join(self.debug_dir, "02_clahe.png"), enhanced)
        return gray, enhanced

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 3 – Perspective Correction
    # ════════════════════════════════════════════════════════════════════

    def _align_sheet(self, gray: np.ndarray, enhanced: np.ndarray,
                     color: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
        try:
            blurred = cv2.GaussianBlur(enhanced, (5, 5), 0)
            edges = cv2.Canny(blurred, 30, 120)
            kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))
            edges = cv2.dilate(edges, kernel, iterations=2)
            contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            if not contours:
                return enhanced, color
            for cnt in sorted(contours, key=cv2.contourArea, reverse=True)[:5]:
                peri = cv2.arcLength(cnt, True)
                approx = cv2.approxPolyDP(cnt, 0.02 * peri, True)
                if len(approx) == 4 and cv2.contourArea(approx) > gray.size * 0.15:
                    pts = self._order_points(approx.reshape(4, 2).astype(np.float32))
                    w = max(np.linalg.norm(pts[1]-pts[0]), np.linalg.norm(pts[2]-pts[3]))
                    h = max(np.linalg.norm(pts[3]-pts[0]), np.linalg.norm(pts[2]-pts[1]))
                    dst = np.array([[0,0],[w-1,0],[w-1,h-1],[0,h-1]], dtype=np.float32)
                    M = cv2.getPerspectiveTransform(pts, dst)
                    warped = cv2.warpPerspective(color, M, (int(w), int(h)))
                    wg = cv2.cvtColor(warped, cv2.COLOR_BGR2GRAY)
                    clahe = cv2.createCLAHE(clipLimit=self.clahe_clip, tileGridSize=self.clahe_grid)
                    wg = clahe.apply(wg)
                    wg = cv2.bilateralFilter(wg, 9, 75, 75)
                    print("[OMR] Perspective aligned")
                    return wg, warped
            print("[OMR] No quad for alignment, using original")
        except Exception as e:
            print(f"[OMR] Alignment error: {e}")
        return enhanced, color

    @staticmethod
    def _order_points(pts: np.ndarray) -> np.ndarray:
        rect = np.zeros((4, 2), dtype=np.float32)
        s = pts.sum(axis=1); d = np.diff(pts, axis=1)
        rect[0] = pts[np.argmin(s)]; rect[2] = pts[np.argmax(s)]
        rect[1] = pts[np.argmin(d)]; rect[3] = pts[np.argmax(d)]
        return rect

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 4 – Find ALL Circles (filled + empty)
    # ════════════════════════════════════════════════════════════════════

    def _find_all_circles(self, gray: np.ndarray, color: np.ndarray) -> List[Dict]:
        """
        Detect every circular shape — both solid-filled and thin-outline.
        Uses three complementary methods and merges by proximity.
        """
        m1 = self._circles_hough(gray)
        m2 = self._circles_contour_adaptive(gray)
        m3 = self._circles_contour_canny(gray)
        
        print(f"[OMR] Circle methods — Hough:{len(m1)}  Adaptive:{len(m2)}  Canny:{len(m3)}")
        
        # Merge: Hough is best for uniform circles, contour methods supplement
        merged = list(m1)
        for c in m2 + m3:
            if not self._has_nearby(c, merged, dist=15):
                merged.append(c)
        
        # Auto-calibrate size range from the cluster of detected circles
        if self.enable_auto_calibration and len(merged) >= 5:
            areas = sorted(b['area'] for b in merged)
            q1, q3 = np.percentile(areas, 25), np.percentile(areas, 75)
            iqr = q3 - q1
            self.bubble_area_min = max(20, q1 - 2.0 * iqr)
            self.bubble_area_max = q3 + 2.0 * iqr
            print(f"[OMR] Calibrated area: {self.bubble_area_min:.0f}–{self.bubble_area_max:.0f}")
        
        # Filter
        valid = [b for b in merged if self._is_valid_bubble(b)]
        print(f"[OMR] {len(valid)} valid circles after filtering")
        
        if self.debug and color is not None:
            dbg = color.copy()
            for b in valid:
                cv2.circle(dbg, (b['cx'], b['cy']), int(b.get('radius', 10)), (0,255,0), 2)
            cv2.imwrite(os.path.join(self.debug_dir, "04_circles.png"), dbg)
        
        return valid

    def _circles_hough(self, gray: np.ndarray) -> List[Dict]:
        """Hough Circle Transform — finds both filled and outline circles."""
        blurred = cv2.GaussianBlur(gray, (9, 9), 2)
        h, w = gray.shape
        min_r = max(5, w // 80)
        max_r = max(20, w // 12)
        min_dist = max(min_r * 2, 15)
        
        results = []
        # Two passes with different sensitivity to catch both strong and faint circles
        for p1, p2 in [(80, 28), (50, 22)]:
            circles = cv2.HoughCircles(
                blurred, cv2.HOUGH_GRADIENT, dp=1.2,
                minDist=min_dist, param1=p1, param2=p2,
                minRadius=min_r, maxRadius=max_r
            )
            if circles is not None:
                for (cx, cy, r) in np.uint16(np.around(circles[0])):
                    c = self._make_circle_dict(int(cx), int(cy), int(r), "hough")
                    if not self._has_nearby(c, results, dist=12):
                        results.append(c)
        return results

    def _circles_contour_adaptive(self, gray: np.ndarray) -> List[Dict]:
        """Adaptive threshold → contour → shape filter."""
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)
        binary = cv2.adaptiveThreshold(
            blurred, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
            cv2.THRESH_BINARY_INV, 31, 12)
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3))
        binary = cv2.morphologyEx(binary, cv2.MORPH_CLOSE, kernel, iterations=1)
        contours, _ = cv2.findContours(binary, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        return [b for cnt in contours if (b := self._contour_to_circle(cnt, "adapt")) is not None]

    def _circles_contour_canny(self, gray: np.ndarray) -> List[Dict]:
        """Canny edge → contour — good at picking up thin outlines."""
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)
        edges = cv2.Canny(blurred, 50, 150)
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3))
        edges = cv2.dilate(edges, kernel, iterations=1)
        contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        return [b for cnt in contours if (b := self._contour_to_circle(cnt, "canny")) is not None]

    # ── helpers ──

    def _contour_to_circle(self, cnt, source: str) -> Optional[Dict]:
        area = cv2.contourArea(cnt)
        if area < 20 or area > 50000:
            return None
        peri = cv2.arcLength(cnt, True)
        if peri < 15:
            return None
        circ = 4 * np.pi * area / (peri * peri) if peri > 0 else 0
        if circ < 0.25:
            return None
        x, y, w, h = cv2.boundingRect(cnt)
        if h == 0 or w == 0:
            return None
        aspect = w / h
        if aspect < 0.3 or aspect > 3.0:
            return None
        M = cv2.moments(cnt)
        if M["m00"] == 0:
            return None
        cx, cy = int(M["m10"]/M["m00"]), int(M["m01"]/M["m00"])
        radius = np.sqrt(area / np.pi)
        hull = cv2.convexHull(cnt)
        ha = cv2.contourArea(hull)
        solidity = area / ha if ha > 0 else 0
        return {
            'contour': cnt, 'cx': cx, 'cy': cy, 'radius': float(radius),
            'area': float(area), 'circularity': circ,
            'x': x, 'y': y, 'w': w, 'h': h,
            'aspect': aspect, 'solidity': solidity, 'source': source
        }

    @staticmethod
    def _make_circle_dict(cx: int, cy: int, r: int, source: str) -> Dict:
        angles = np.linspace(0, 2*np.pi, 36, endpoint=False)
        pts = np.array([[int(cx + r*np.cos(a)), int(cy + r*np.sin(a))] for a in angles])
        contour = pts.reshape(-1, 1, 2).astype(np.int32)
        return {
            'contour': contour, 'cx': cx, 'cy': cy, 'radius': r,
            'area': float(np.pi * r * r), 'circularity': 1.0,
            'x': cx-r, 'y': cy-r, 'w': 2*r, 'h': 2*r,
            'aspect': 1.0, 'solidity': 1.0, 'source': source
        }

    @staticmethod
    def _has_nearby(b: Dict, others: List[Dict], dist: float) -> bool:
        for o in others:
            if np.hypot(b['cx'] - o['cx'], b['cy'] - o['cy']) < dist:
                return True
        return False

    def _is_valid_bubble(self, b: Dict) -> bool:
        if b['area'] < self.bubble_area_min or b['area'] > self.bubble_area_max:
            return False
        if b['circularity'] < self.bubble_circularity_min:
            return False
        lo, hi = self.bubble_aspect_ratio_range
        if b.get('aspect', 1) < lo or b.get('aspect', 1) > hi:
            return False
        if b.get('solidity', 1) < 0.50:
            return False
        return True

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 5 – Grid Construction
    # ════════════════════════════════════════════════════════════════════

    def _build_grid(self, circles: List[Dict], num_choices: int,
                    num_questions: int) -> Tuple[List[List[Dict]], dict]:
        """
        Organize detected circles into a grid [row][col] by clustering
        X-coordinates into columns and Y-coordinates into rows.
        Returns (grid_rows, metadata).  grid_rows[i] is sorted left→right.
        """
        if len(circles) < num_choices:
            return [], {}
        
        xs = np.array([c['cx'] for c in circles], dtype=np.float64)
        ys = np.array([c['cy'] for c in circles], dtype=np.float64)
        
        # ── Cluster X into columns ──
        col_centers = self._cluster_1d(xs, num_choices)
        if col_centers is None or len(col_centers) != num_choices:
            print(f"[OMR] Column clustering failed (got {len(col_centers) if col_centers is not None else 0} cols, need {num_choices})")
            return [], {}
        col_centers = sorted(col_centers)
        
        # ── Cluster Y into rows ──
        row_centers = self._cluster_1d(ys, num_questions)
        if row_centers is None or len(row_centers) < 2:
            print(f"[OMR] Row clustering failed")
            return [], {}
        row_centers = sorted(row_centers)
        
        # ── Assign each circle to nearest (row, col) ──
        col_tol = np.median(np.diff(sorted(col_centers))) * 0.45 if len(col_centers) > 1 else 50
        row_tol = np.median(np.diff(sorted(row_centers))) * 0.45 if len(row_centers) > 1 else 50
        
        grid: Dict[int, Dict[int, Dict]] = {}  # {row_idx: {col_idx: circle}}
        
        for c in circles:
            # Find nearest column
            col_dists = [abs(c['cx'] - cc) for cc in col_centers]
            ci = int(np.argmin(col_dists))
            if col_dists[ci] > col_tol:
                continue
            # Find nearest row
            row_dists = [abs(c['cy'] - rc) for rc in row_centers]
            ri = int(np.argmin(row_dists))
            if row_dists[ri] > row_tol:
                continue
            # If cell is already occupied, keep the one closer to the center
            if ri in grid and ci in grid[ri]:
                existing = grid[ri][ci]
                old_d = abs(existing['cx'] - col_centers[ci]) + abs(existing['cy'] - row_centers[ri])
                new_d = abs(c['cx'] - col_centers[ci]) + abs(c['cy'] - row_centers[ri])
                if new_d >= old_d:
                    continue
            grid.setdefault(ri, {})[ci] = c
        
        # ── Build output rows ──
        result = []
        for ri in sorted(grid.keys()):
            row_dict = grid[ri]
            if len(row_dict) < max(2, num_choices * 0.5):
                continue  # too few in this row, likely noise
            row_list = [row_dict[ci] for ci in sorted(row_dict.keys())]
            result.append(row_list)
        
        meta = {
            "columns_found": len(col_centers),
            "rows_found": len(row_centers),
            "grid_rows_used": len(result),
            "col_centers": [round(c, 1) for c in col_centers],
            "row_centers": [round(c, 1) for c in row_centers[:num_questions]],
        }
        print(f"[OMR] Grid built: {meta['columns_found']} cols × {meta['rows_found']} rows → {len(result)} usable rows")
        return result[:num_questions], meta

    def _cluster_1d(self, values: np.ndarray, expected_k: int) -> Optional[List[float]]:
        """
        Cluster 1D values into expected_k groups.
        Uses iterative k-means style with smart initialization.
        """
        if len(values) < expected_k:
            return None
        
        sorted_v = np.sort(values)
        
        # Initialize centers by splitting sorted values into expected_k equal parts
        chunk = len(sorted_v) // expected_k
        if chunk < 1:
            chunk = 1
        centers = []
        for i in range(expected_k):
            start = i * chunk
            end = min(start + chunk, len(sorted_v))
            centers.append(np.mean(sorted_v[start:end]))
        
        # Iterate k-means
        for _ in range(30):
            # Assign
            labels = np.array([int(np.argmin([abs(v - c) for c in centers])) for v in sorted_v])
            # Update
            new_centers = []
            for k in range(expected_k):
                members = sorted_v[labels == k]
                if len(members) > 0:
                    new_centers.append(float(np.mean(members)))
                else:
                    new_centers.append(centers[k])
            if np.allclose(centers, new_centers, atol=0.5):
                break
            centers = new_centers
        
        # Validate: each cluster should have at least 1 member
        labels = np.array([int(np.argmin([abs(v - c) for c in centers])) for v in sorted_v])
        for k in range(expected_k):
            if np.sum(labels == k) == 0:
                return None  # empty cluster
        
        return centers

    def _fallback_row_grouping(self, circles: List[Dict], num_choices: int,
                                num_questions: int) -> Tuple[List[List[Dict]], dict]:
        """Fallback: group by Y gaps when grid clustering fails."""
        if not circles:
            return [], {}
        
        by_y = sorted(circles, key=lambda b: b['cy'])
        ys = np.array([b['cy'] for b in by_y])
        diffs = np.diff(ys)
        
        if len(diffs) == 0:
            return [by_y], {"method": "fallback_single_row"}
        
        threshold = self._otsu_threshold_1d(diffs)
        
        rows: List[List[Dict]] = []
        cur = [by_y[0]]
        for i in range(1, len(by_y)):
            gap = by_y[i]['cy'] - np.mean([b['cy'] for b in cur])
            if gap > threshold:
                rows.append(cur)
                cur = [by_y[i]]
            else:
                cur.append(by_y[i])
        if cur:
            rows.append(cur)
        
        # Filter small rows, sort each L→R
        min_b = max(2, num_choices * 0.4)
        rows = [sorted(r, key=lambda b: b['cx']) for r in rows if len(r) >= min_b]
        
        return rows[:num_questions], {"method": "fallback_row_clustering", "rows": len(rows)}

    @staticmethod
    def _otsu_threshold_1d(diffs: np.ndarray) -> float:
        pos = diffs[diffs > 1]
        if len(pos) < 2:
            return 20.0
        s = np.sort(pos)
        best_t, best_s = float(np.median(s)), -1.0
        for t in s:
            lo, hi = s[s <= t], s[s > t]
            if len(lo) == 0 or len(hi) == 0:
                continue
            score = (len(lo)/len(s)) * (len(hi)/len(s)) * (lo.mean() - hi.mean())**2
            if score > best_s:
                best_s, best_t = score, t
        return max(10, best_t * 0.7)

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 6 – Fill Ratio
    # ════════════════════════════════════════════════════════════════════

    def _get_dark_mask(self, gray: np.ndarray) -> np.ndarray:
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)
        _, otsu = cv2.threshold(blurred, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)
        _, fixed = cv2.threshold(blurred, 160, 255, cv2.THRESH_BINARY_INV)
        combined = cv2.bitwise_or(otsu, fixed)
        if self.debug:
            cv2.imwrite(os.path.join(self.debug_dir, "05_dark.png"), combined)
        return combined

    def _fill_grid(self, grid_rows: List[List[Dict]], dark_mask: np.ndarray,
                   gray: np.ndarray, choices: List[str]) -> Dict[int, Dict[str, float]]:
        result: Dict[int, Dict[str, float]] = {}
        for qi, row in enumerate(grid_rows):
            q_num = qi + 1
            n = min(len(choices), len(row))
            if n == 0:
                continue
            fills = {}
            for ci in range(n):
                fills[choices[ci]] = self._bubble_fill(row[ci], dark_mask, gray)
            result[q_num] = fills
            if self.debug:
                print(f"  Q{q_num}: {' | '.join(f'{c}={v:.3f}' for c,v in fills.items())}")
        return result

    def _bubble_fill(self, bubble: Dict, dark_mask: np.ndarray,
                     gray: np.ndarray) -> float:
        """
        Compute how 'filled' a bubble is.
        Combines dark-pixel ratio with local intensity comparison.
        """
        cnt = bubble['contour']
        area = cv2.contourArea(cnt)
        if area < 1:
            return 0.0
        
        mask = np.zeros(gray.shape[:2], dtype=np.uint8)
        cv2.drawContours(mask, [cnt], 0, 255, -1)
        
        # (A) Dark-pixel fraction inside
        dark_in = cv2.countNonZero(mask & dark_mask)
        ratio_dark = dark_in / area
        
        # (B) Intensity contrast: compare inside vs surrounding ring
        mean_in = cv2.mean(gray, mask=mask)[0]
        kern = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (7, 7))
        ring = cv2.subtract(cv2.dilate(mask, kern, iterations=2), mask)
        ring_px = cv2.countNonZero(ring)
        mean_out = cv2.mean(gray, mask=ring)[0] if ring_px > 10 else 200.0
        intensity_ratio = max(0.0, (mean_out - mean_in) / mean_out) if mean_out > 10 else 0.0
        
        # Weighted combination
        combined = 0.45 * ratio_dark + 0.55 * intensity_ratio
        return min(1.0, max(0.0, combined))

    # ════════════════════════════════════════════════════════════════════
    #  STAGE 7 – Answer Extraction
    # ════════════════════════════════════════════════════════════════════

    def _extract_answers(self, bubbles_data: Dict[int, Dict[str, float]],
                         answer_count: int) -> Tuple[List[Optional[str]], dict]:
        answers = [None] * answer_count
        meta = {
            "total_questions_detected": len(bubbles_data),
            "questions_processed": 0,
            "questions_skipped": 0,
            "confidence_scores": {},
            "bubble_fill_ratios": {},
            "detection_details": {},
            "quality_flags": []
        }
        
        for q in sorted(bubbles_data.keys()):
            if q > answer_count:
                break
            fills = bubbles_data[q]
            if not fills:
                meta["questions_skipped"] += 1
                continue
            
            meta["bubble_fill_ratios"][q] = {k: round(v, 4) for k, v in fills.items()}
            
            ranked = sorted(fills.items(), key=lambda x: x[1], reverse=True)
            best_ch, best_f = ranked[0]
            second_f = ranked[1][1] if len(ranked) > 1 else 0.0
            gap = best_f - second_f
            
            meta["detection_details"][q] = {
                "best": best_ch, "best_fill": round(best_f, 4),
                "second_fill": round(second_f, 4), "gap": round(gap, 4),
                "all": {k: round(v, 4) for k, v in fills.items()}
            }
            
            # Decision
            if best_f < 0.03:
                meta["questions_skipped"] += 1
                meta["quality_flags"].append(f"Q{q}: likely unanswered")
                continue
            
            conf = 0.0
            if gap >= self.gap_threshold and best_f >= self.fill_threshold_min:
                conf = min(1.0, best_f * 2 + gap)
            elif best_f >= self.fill_threshold_high:
                conf = min(1.0, best_f * 1.5)
            elif gap >= 0.08 and second_f < 0.04:
                conf = min(1.0, gap * 2)
            elif best_f >= self.fill_threshold_min:
                conf = best_f
                meta["quality_flags"].append(f"Q{q}: low confidence ({best_f:.2f})")
            else:
                meta["questions_skipped"] += 1
                continue
            
            answers[q - 1] = best_ch
            meta["confidence_scores"][q] = round(conf, 3)
            meta["questions_processed"] += 1
        
        meta["questions_answered"] = sum(1 for a in answers if a is not None)
        nf = len(meta["quality_flags"])
        meta["accuracy_estimate"] = "high" if nf == 0 else "medium" if nf <= 2 else "low"
        return answers, meta
