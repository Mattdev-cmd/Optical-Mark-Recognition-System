from fastapi import APIRouter, HTTPException, status, Depends
from bson.objectid import ObjectId
from typing import List
from datetime import datetime
from ..models import ExamCreate, ExamUpdate, ExamResponse
from ..utils.auth import get_current_user
from ..database import get_db

router = APIRouter(prefix="/exams", tags=["Exams"])

@router.post("/create", response_model=ExamResponse, status_code=status.HTTP_201_CREATED)
async def create_exam(exam_data: ExamCreate, current_user: dict = Depends(get_current_user)):
    """Create a new exam"""
    db = get_db()
    
    # Validate answer key length
    if len(exam_data.answer_key) != exam_data.total_questions:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Answer key length must match total questions"
        )
    
    # Create exam
    exam_dict = exam_data.dict()
    exam_dict["created_by"] = current_user["user_id"]
    exam_dict["created_at"] = exam_dict["updated_at"] = datetime.utcnow()
    exam_dict["answer_key"] = [ak.dict() for ak in exam_data.answer_key]
    
    result = db.exams.insert_one(exam_dict)
    
    created_exam = db.exams.find_one({"_id": result.inserted_id})
    
    return ExamResponse(
        id=str(created_exam["_id"]),
        name=created_exam["name"],
        subject=created_exam["subject"],
        total_questions=created_exam["total_questions"],
        choices=created_exam["choices"],
        answer_key=created_exam["answer_key"],
        created_by=created_exam["created_by"],
        created_at=created_exam["created_at"],
        updated_at=created_exam["updated_at"]
    )

@router.get("", response_model=List[ExamResponse])
async def get_exams(current_user: dict = Depends(get_current_user)):
    """Get all exams created by user"""
    db = get_db()
    
    print(f"[GET_EXAMS] User ID: {current_user.get('user_id')}")
    
    exams = list(db.exams.find({"created_by": current_user["user_id"]}))
    
    print(f"[GET_EXAMS] Found {len(exams)} exams")
    
    results = []
    for exam in exams:
        try:
            results.append(ExamResponse(
                id=str(exam["_id"]),
                name=exam.get("name", "Untitled Exam"),
                subject=exam.get("subject"),
                total_questions=exam.get("total_questions", 0),
                choices=exam.get("choices", []),
                answer_key=exam.get("answer_key", []),
                created_by=exam.get("created_by"),
                created_at=exam.get("created_at"),
                updated_at=exam.get("updated_at")
            ))
        except Exception as e:
            print(f"[GET_EXAMS ERROR] Failed to process exam {exam.get('_id')}: {str(e)}")
            continue
    
    return results

@router.get("/{exam_id}", response_model=ExamResponse)
async def get_exam(exam_id: str, current_user: dict = Depends(get_current_user)):
    """Get exam details"""
    db = get_db()
    
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
    
    return ExamResponse(
        id=str(exam["_id"]),
        name=exam.get("name", "Untitled Exam"),
        subject=exam.get("subject"),
        total_questions=exam.get("total_questions", 0),
        choices=exam.get("choices", []),
        answer_key=exam.get("answer_key", []),
        created_by=exam.get("created_by"),
        created_at=exam.get("created_at"),
        updated_at=exam.get("updated_at")
    )

@router.put("/{exam_id}", response_model=ExamResponse)
async def update_exam(exam_id: str, exam_update: ExamUpdate, 
                     current_user: dict = Depends(get_current_user)):
    """Update exam"""
    db = get_db()
    
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
    
    # Check ownership
    if exam["created_by"] != current_user["user_id"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You can only update your own exams"
        )
    
    # Update fields
    update_data = exam_update.dict(exclude_unset=True)
    if "answer_key" in update_data:
        update_data["answer_key"] = [ak.dict() for ak in exam_update.answer_key]
    
    update_data["updated_at"] = datetime.utcnow()
    
    db.exams.update_one({"_id": ObjectId(exam_id)}, {"$set": update_data})
    
    updated_exam = db.exams.find_one({"_id": ObjectId(exam_id)})
    
    return ExamResponse(
        id=str(updated_exam["_id"]),
        name=updated_exam.get("name", "Untitled Exam"),
        subject=updated_exam.get("subject"),
        total_questions=updated_exam.get("total_questions", 0),
        choices=updated_exam.get("choices", []),
        answer_key=updated_exam.get("answer_key", []),
        created_by=updated_exam.get("created_by"),
        created_at=updated_exam.get("created_at"),
        updated_at=updated_exam.get("updated_at")
    )

@router.delete("/{exam_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_exam(exam_id: str, current_user: dict = Depends(get_current_user)):
    """Delete exam"""
    db = get_db()
    
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
    
    # Check ownership
    if exam["created_by"] != current_user["user_id"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You can only delete your own exams"
        )
    
    db.exams.delete_one({"_id": ObjectId(exam_id)})
    
    return None
