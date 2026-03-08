import cv2
import numpy as np
from PIL import Image
from typing import List, Tuple, Optional
from skimage import measure
from scipy import ndimage
import io

class OMRProcessor:
    def __init__(self, min_bubble_fill_ratio: float = 0.4):
        self.min_bubble_fill_ratio = min_bubble_fill_ratio
        self.debug = False

    def process_answer_sheet(self, image_data: bytes, answer_count: int = 20, 
                            choices: List[str] = None) -> Tuple[List[Optional[str]], dict]:
        """
        Main function to process OMR answer sheet
        Returns detected answers and processing metadata
        """
        try:
            # Convert bytes to image
            img = self._load_image(image_data)
            
            # Preprocess image
            preprocessed = self._preprocess_image(img)
            
            # Detect sheet alignment
            aligned_img = self._align_sheet(preprocessed, img)
            
            # Detect bubbles
            bubbles = self._detect_bubbles(aligned_img, answer_count, choices or ["A", "B", "C", "D", "E"])
            
            # Extract answers
            answers, metadata = self._extract_answers(bubbles, answer_count)
            
            return answers, metadata
            
        except Exception as e:
            return None, {"error": str(e)}

    def _load_image(self, image_data: bytes) -> np.ndarray:
        """Load image from bytes"""
        nparr = np.frombuffer(image_data, np.uint8)
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        
        if img is None:
            raise ValueError("Failed to load image")
            
        return img

    def _preprocess_image(self, img: np.ndarray) -> np.ndarray:
        """Preprocess image for bubble detection"""
        # Convert to grayscale
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        
        # Apply CLAHE for contrast enhancement
        clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
        enhanced = clahe.apply(gray)
        
        # Apply bilateral filter to reduce noise while keeping edges
        filtered = cv2.bilateralFilter(enhanced, 9, 75, 75)
        
        # Apply Otsu's thresholding
        _, binary = cv2.threshold(filtered, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
        
        return binary

    def _align_sheet(self, binary_img: np.ndarray, original_img: np.ndarray) -> np.ndarray:
        """
        Align sheet using corner/edge detection
        Uses perspective transformation to straighten tilted images
        """
        try:
            # Find contours
            contours, _ = cv2.findContours(binary_img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            
            if not contours:
                return original_img
            
            # Find largest contour (sheet boundary)
            largest_contour = max(contours, key=cv2.contourArea)
            
            # Get bounding rectangle
            epsilon = 0.02 * cv2.arcLength(largest_contour, True)
            approx = cv2.approxPolyDP(largest_contour, epsilon, True)
            
            if len(approx) == 4:
                # Perspective transformation
                pts = approx.reshape(4, 2)
                
                # Order points
                ordered_pts = self._order_points(pts)
                
                # Get width and height
                width = max(
                    np.linalg.norm(ordered_pts[1] - ordered_pts[0]),
                    np.linalg.norm(ordered_pts[2] - ordered_pts[3])
                )
                height = max(
                    np.linalg.norm(ordered_pts[3] - ordered_pts[0]),
                    np.linalg.norm(ordered_pts[2] - ordered_pts[1])
                )
                
                # Create transformation matrix
                dst_pts = np.array([
                    [0, 0],
                    [width - 1, 0],
                    [width - 1, height - 1],
                    [0, height - 1]
                ], dtype=np.float32)
                
                M = cv2.getPerspectiveTransform(ordered_pts.astype(np.float32), dst_pts)
                aligned = cv2.warpPerspective(original_img, M, (int(width), int(height)))
                
                return aligned
        except Exception:
            pass
        
        return original_img

    def _order_points(self, pts: np.ndarray) -> np.ndarray:
        """Order 4 corner points in standard order"""
        rect = np.zeros((4, 2), dtype=np.float32)
        
        s = pts.sum(axis=1)
        rect[0] = pts[np.argmin(s)]
        rect[2] = pts[np.argmax(s)]
        
        diff = np.diff(pts, axis=1)
        rect[1] = pts[np.argmin(diff)]
        rect[3] = pts[np.argmax(diff)]
        
        return rect

    def _detect_bubbles(self, img: np.ndarray, answer_count: int, 
                       choices: List[str]) -> dict:
        """
        Detect answer bubbles in the image
        Returns dict with structure: {question_num: {choice: fill_ratio}}
        """
        # Convert to grayscale if needed
        if len(img.shape) == 3:
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        else:
            gray = img
        
        # Apply threshold
        _, binary = cv2.threshold(gray, 150, 255, cv2.THRESH_BINARY_INV)
        
        # Find contours
        contours, _ = cv2.findContours(binary, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        bubbles = {}
        
        # Filter circular contours (bubbles)
        circular_contours = []
        for contour in contours:
            area = cv2.contourArea(contour)
            perimeter = cv2.arcLength(contour, True)
            
            # Filter by size (avoid too small or too large)
            if area < 100 or area > 5000:
                continue
            
            # Check circularity
            if perimeter == 0:
                continue
            
            circularity = 4 * np.pi * area / (perimeter * perimeter)
            if circularity > 0.6:  # More circular
                circular_contours.append(contour)
        
        # Group bubbles by row and column
        bubble_info = self._group_bubbles(circular_contours, len(choices), answer_count)
        
        # Calculate fill ratio for each bubble
        for question_num, choice_idx, contour in bubble_info:
            fill_ratio = self._calculate_fill_ratio(binary, contour)
            
            if question_num not in bubbles:
                bubbles[question_num] = {}
            
            choice = choices[choice_idx] if choice_idx < len(choices) else str(choice_idx)
            bubbles[question_num][choice] = fill_ratio
        
        return bubbles

    def _group_bubbles(self, contours: List, num_choices: int, 
                      num_questions: int) -> List[Tuple[int, int, object]]:
        """
        Group bubbles into question and choice
        Returns list of (question_num, choice_idx, contour)
        """
        bubble_info = []
        
        # Get centroids
        centroids = []
        for i, contour in enumerate(contours):
            M = cv2.moments(contour)
            if M["m00"] != 0:
                cx = int(M["m10"] / M["m00"])
                cy = int(M["m01"] / M["m00"])
                centroids.append((cx, cy, i, contour))
        
        if not centroids:
            return bubble_info
        
        # Sort by y-coordinate (rows = questions), then x-coordinate (columns = choices)
        centroids.sort(key=lambda x: (x[1], x[0]))
        
        # Group into question-choice pairs
        question_num = 0
        prev_y = -1
        threshold_y = 30  # Threshold for same row
        
        for cx, cy, contour_idx, contour in centroids:
            if abs(cy - prev_y) > threshold_y:
                question_num += 1
                choice_idx = 0
                prev_y = cy
            else:
                choice_idx += 1
            
            if question_num <= num_questions and choice_idx < num_choices:
                bubble_info.append((question_num, choice_idx, contour))
        
        return bubble_info

    def _calculate_fill_ratio(self, binary_img: np.ndarray, contour) -> float:
        """Calculate the fill ratio of a bubble"""
        area = cv2.contourArea(contour)
        
        # Create mask for this bubble
        mask = np.zeros_like(binary_img)
        cv2.drawContours(mask, [contour], 0, 255, -1)
        
        # Count non-zero pixels
        filled_pixels = cv2.countNonZero(mask & binary_img)
        
        if area == 0:
            return 0.0
        
        fill_ratio = filled_pixels / area
        return min(1.0, max(0.0, fill_ratio))

    def _extract_answers(self, bubbles: dict, answer_count: int) -> Tuple[List[Optional[str]], dict]:
        """
        Extract selected answers from bubble detection data
        """
        answers = [None] * answer_count
        metadata = {
            "total_bubbles_detected": sum(len(v) for v in bubbles.values()),
            "questions_processed": 0,
            "confidence_scores": {}
        }
        
        for question_num in sorted(bubbles.keys()):
            if question_num > answer_count:
                break
            
            choices_data = bubbles[question_num]
            
            # Find most filled bubble
            max_fill = 0.0
            selected_choice = None
            confidence = 0.0
            
            for choice, fill_ratio in choices_data.items():
                if fill_ratio > max_fill:
                    max_fill = fill_ratio
                    selected_choice = choice
                    confidence = fill_ratio
            
            # Check if bubble is sufficiently filled
            if max_fill >= self.min_bubble_fill_ratio:
                answers[question_num - 1] = selected_choice
                metadata["confidence_scores"][question_num] = confidence
                metadata["questions_processed"] += 1
        
        return answers, metadata
