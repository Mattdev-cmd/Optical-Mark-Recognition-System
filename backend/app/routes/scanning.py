from fastapi import APIRouter, HTTPException, status, Depends, UploadFile, File, Form
from bson.objectid import ObjectId
from typing import List
from datetime import datetime
from ..models import ResultResponse, StudentAnswer
from ..utils.auth import get_current_user
from ..database import get_db
from ..processing.omr_processor import OMRProcessor

router = APIRouter(prefix="/scan", tags=["Scanning"])
processor = OMRProcessor()

@router.post("/process-sheet", status_code=status.HTTP_200_OK)
async def process_answer_sheet(
    exam_id: str = Form(...),
    student_name: str = Form(...),
    sheet_image: UploadFile = File(...),
    current_user: dict = Depends(get_current_user)
):
    """Process answer sheet and calculate score"""
    db = get_db()
    
    # Validate exam exists
    try:
        exam = db.exams.find_one({"_id": ObjectId(exam_id)})
    except:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid exam ID"
        )
    
    if not exam:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Exam not found"
        )
    
    try:
        # Read image file
        image_data = await sheet_image.read()
        print(f"[SCAN] Processing image: {len(image_data)} bytes, exam: {exam['name']}, questions: {exam['total_questions']}, choices: {exam['choices']}")
        
        # Process OMR
        detected_answers, metadata = processor.process_answer_sheet(
            image_data,
            answer_count=exam["total_questions"],
            choices=exam["choices"]
        )
        
        print(f"[SCAN] Detection result: answers={detected_answers}, metadata={metadata}")
        
        if detected_answers is None:
            error_msg = metadata.get("error", "Unknown error")
            traceback_info = metadata.get("traceback", "")
            print(f"[SCAN ERROR] OMR processing failed: {error_msg}")
            if traceback_info:
                print(f"[SCAN TRACEBACK] {traceback_info}")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Failed to process answer sheet: {error_msg}"
            )
        
        # Compare with answer key and calculate score
        answer_key_map = {ak["question_number"]: ak["correct_answer"] 
                         for ak in exam["answer_key"]}
        
        student_answers = []
        correct_count = 0
        
        for q_num in range(1, exam["total_questions"] + 1):
            detected = detected_answers[q_num - 1]
            correct = answer_key_map.get(q_num, "")
            
            is_correct = detected == correct if detected else False
            if is_correct:
                correct_count += 1
            
            student_answers.append(StudentAnswer(
                question_number=q_num,
                student_answer=detected,
                correct_answer=correct,
                is_correct=is_correct
            ))
        
        # Calculate percentage
        score_percentage = (correct_count / exam["total_questions"]) * 100 if exam["total_questions"] > 0 else 0
        
        # Save result
        result_data = {
            "student_name": student_name,
            "exam_id": exam_id,
            "exam_name": exam["name"],
            "total_questions": exam["total_questions"],
            "correct_answers": correct_count,
            "score_percentage": round(score_percentage, 2),
            "student_answers": [sa.dict() for sa in student_answers],
            "scanned_by": current_user["user_id"],
            "scanned_at": datetime.utcnow()
        }
        
        result = db.results.insert_one(result_data)
        
        return {
            "result_id": str(result.inserted_id),
            "student_name": student_name,
            "exam_name": exam["name"],
            "total_questions": exam["total_questions"],
            "correct_answers": correct_count,
            "score_percentage": round(score_percentage, 2),
            "student_answers": [sa.dict() for sa in student_answers],
            "metadata": {k: str(v) if not isinstance(v, (int, float, str, bool, type(None))) else v 
                        for k, v in metadata.items()}
        }
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Processing error: {str(e)}"
        )

@router.get("/results/{exam_id}")
async def get_exam_results(exam_id: str, current_user: dict = Depends(get_current_user)):
    """Get all results for an exam"""
    db = get_db()
    
    # Verify exam ownership
    try:
        exam = db.exams.find_one({"_id": ObjectId(exam_id)})
    except:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid exam ID"
        )
    
    if not exam:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Exam not found"
        )
    
    results = list(db.results.find({"exam_id": exam_id}))
    
    return [
        {
            "result_id": str(r["_id"]),
            "student_name": r["student_name"],
            "exam_name": r["exam_name"],
            "total_questions": r["total_questions"],
            "correct_answers": r["correct_answers"],
            "percentage": f"{r['score_percentage']:.2f}%",
            "scanned_at": r["scanned_at"]
        }
        for r in results
    ]

@router.get("/result/{result_id}")
async def get_result_details(result_id: str, current_user: dict = Depends(get_current_user)):
    """Get detailed result information"""
    db = get_db()
    
    try:
        result = db.results.find_one({"_id": ObjectId(result_id)})
    except:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid result ID"
        )
    
    if not result:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Result not found"
        )
    
    return {
        "result_id": str(result["_id"]),
        "student_name": result["student_name"],
        "exam_name": result["exam_name"],
        "total_questions": result["total_questions"],
        "correct_answers": result["correct_answers"],
        "score_percentage": result["score_percentage"],
        "student_answers": result["student_answers"],
        "metadata": None
    }
