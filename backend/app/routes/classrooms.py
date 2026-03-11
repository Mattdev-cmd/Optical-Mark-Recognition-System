from fastapi import APIRouter, Depends, HTTPException, status
from typing import Dict, List, Optional
from datetime import datetime
from bson import ObjectId
from ..database import get_db
from ..models.classroom import (
    ClassroomCreate, ClassroomUpdate, ClassroomResponse,
    ClassroomWithStudents, StudentClassRecord, ClassroomStats
)
from ..utils.auth import get_current_user

router = APIRouter(prefix="/api/classrooms", tags=["classrooms"])


# ============= CLASSROOM CRUD OPERATIONS =============

@router.post("/", response_model=ClassroomResponse, status_code=status.HTTP_201_CREATED)
async def create_classroom(
    classroom: ClassroomCreate,
    current_user: dict = Depends(get_current_user)
):
    """Create a new classroom (Teachers only)"""
    db = get_db()
    user_role = current_user.get("role", "user")
    if user_role not in ("teacher", "admin"):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only teachers can create classrooms"
        )
    
    classroom_doc = {
        **classroom.dict(exclude_unset=True),
        "created_by": current_user["user_id"],
        "student_ids": [],
        "exam_ids": [],
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow(),
        "is_active": True
    }
    
    result = db.classrooms.insert_one(classroom_doc)
    classroom_doc["_id"] = str(result.inserted_id)
    
    return classroom_doc


@router.get("/", response_model=List[ClassroomResponse])
async def list_classrooms(
    current_user: dict = Depends(get_current_user),
    skip: int = 0,
    limit: int = 50
):
    """List all classrooms (filtered by teacher if not admin)"""
    db = get_db()
    query = {}
    user_role = current_user.get("role", "user")
    
    if user_role == "teacher":
        query["created_by"] = current_user["user_id"]
    
    classrooms = list(db.classrooms.find(query).skip(skip).limit(limit))
    
    for classroom in classrooms:
        classroom["_id"] = str(classroom["_id"])
        classroom["student_count"] = len(classroom.get("student_ids", []))
    
    return classrooms


@router.get("/{classroom_id}", response_model=ClassroomWithStudents)
async def get_classroom(
    classroom_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Get classroom details with enrolled students"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized to view this classroom")
    
    student_ids = classroom.get("student_ids", [])
    students = []
    for student_id in student_ids:
        try:
            student = db.users.find_one({"_id": ObjectId(student_id)})
            if student:
                students.append({
                    "id": str(student["_id"]),
                    "name": student["name"],
                    "email": student["email"]
                })
        except Exception:
            pass
    
    classroom["_id"] = str(classroom["_id"])
    classroom["students"] = students
    classroom["student_count"] = len(students)
    classroom["total_exams"] = len(classroom.get("exam_ids", []))
    
    return classroom


@router.put("/{classroom_id}", response_model=ClassroomResponse)
async def update_classroom(
    classroom_id: str,
    classroom_update: ClassroomUpdate,
    current_user: dict = Depends(get_current_user)
):
    """Update classroom details"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized to update this classroom")
    
    update_data = classroom_update.dict(exclude_unset=True)
    update_data["updated_at"] = datetime.utcnow()
    
    db.classrooms.update_one(
        {"_id": ObjectId(classroom_id)},
        {"$set": update_data}
    )
    
    updated_classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    updated_classroom["_id"] = str(updated_classroom["_id"])
    
    return updated_classroom


@router.delete("/{classroom_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_classroom(
    classroom_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Delete a classroom (soft delete)"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized to delete this classroom")
    
    db.classrooms.update_one(
        {"_id": ObjectId(classroom_id)},
        {"$set": {"is_active": False, "updated_at": datetime.utcnow()}}
    )
    
    return None


# ============= STUDENT ENROLLMENT OPERATIONS =============

@router.post("/{classroom_id}/students/{student_id}", status_code=status.HTTP_200_OK)
async def enroll_student(
    classroom_id: str,
    student_id: str,
    roll_number: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Enroll a student in a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
        student = db.users.find_one({"_id": ObjectId(student_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom or student not found")
    
    if not classroom or not student:
        raise HTTPException(status_code=404, detail="Classroom or student not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    
    existing_ids = [ObjectId(s) if isinstance(s, str) else s for s in classroom.get("student_ids", [])]
    if ObjectId(student_id) in existing_ids:
        raise HTTPException(status_code=400, detail="Student already enrolled")
    
    db.classrooms.update_one(
        {"_id": ObjectId(classroom_id)},
        {
            "$push": {"student_ids": ObjectId(student_id)},
            "$set": {"updated_at": datetime.utcnow()}
        }
    )
    
    return {
        "message": f"Student {student['name']} enrolled successfully",
        "roll_number": roll_number
    }


@router.delete("/{classroom_id}/students/{student_id}", status_code=status.HTTP_200_OK)
async def remove_student(
    classroom_id: str,
    student_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Remove a student from a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    
    db.classrooms.update_one(
        {"_id": ObjectId(classroom_id)},
        {
            "$pull": {"student_ids": ObjectId(student_id)},
            "$set": {"updated_at": datetime.utcnow()}
        }
    )
    
    return {"message": "Student removed from classroom"}


@router.get("/{classroom_id}/students")
async def list_classroom_students(
    classroom_id: str,
    current_user: dict = Depends(get_current_user)
):
    """List all students in a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    students = []
    for student_id in classroom.get("student_ids", []):
        try:
            student = db.users.find_one({"_id": ObjectId(student_id)})
            if student:
                results = list(db.results.find({
                    "student_id": ObjectId(student_id),
                    "exam_id": {"$in": [ObjectId(e) for e in classroom.get("exam_ids", [])]}
                }))
                
                avg_score = 0
                if results:
                    avg_score = sum(r.get("score_percentage", 0) for r in results) / len(results)
                
                students.append({
                    "id": str(student["_id"]),
                    "name": student["name"],
                    "email": student["email"],
                    "exams_taken": len(results),
                    "average_score": round(avg_score, 2)
                })
        except Exception:
            pass
    
    return students


# ============= CLASS STATISTICS =============

@router.get("/{classroom_id}/statistics", response_model=ClassroomStats)
async def get_classroom_statistics(
    classroom_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Get comprehensive statistics for a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    
    exam_ids = [ObjectId(e) for e in classroom.get("exam_ids", [])]
    results = list(db.results.find({"exam_id": {"$in": exam_ids}})) if exam_ids else []
    
    score_percentages = [r.get("score_percentage", 0) for r in results]
    passed = [s for s in score_percentages if s >= 50]
    
    stats = {
        "classroom_id": str(classroom["_id"]),
        "classroom_name": classroom["name"],
        "total_students": len(classroom.get("student_ids", [])),
        "total_exams": len(exam_ids),
        "average_class_score": sum(score_percentages) / len(score_percentages) if score_percentages else 0.0,
        "highest_score": max(score_percentages) if score_percentages else 0.0,
        "lowest_score": min(score_percentages) if score_percentages else 0.0,
        "students_passed": len(passed),
        "pass_percentage": (len(passed) / len(score_percentages) * 100) if score_percentages else 0.0
    }
    
    return stats


# ============= EXAM ASSIGNMENT TO CLASS =============

@router.post("/{classroom_id}/exams/{exam_id}", status_code=status.HTTP_200_OK)
async def assign_exam_to_class(
    classroom_id: str,
    exam_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Assign an exam to a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
        exam = db.exams.find_one({"_id": ObjectId(exam_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom or exam not found")
    
    if not classroom or not exam:
        raise HTTPException(status_code=404, detail="Classroom or exam not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    
    existing_ids = [ObjectId(e) if isinstance(e, str) else e for e in classroom.get("exam_ids", [])]
    if ObjectId(exam_id) in existing_ids:
        raise HTTPException(status_code=400, detail="Exam already assigned to this classroom")
    
    db.classrooms.update_one(
        {"_id": ObjectId(classroom_id)},
        {
            "$push": {"exam_ids": ObjectId(exam_id)},
            "$set": {"updated_at": datetime.utcnow()}
        }
    )
    
    return {"message": f"Exam '{exam['name']}' assigned to classroom"}


@router.delete("/{classroom_id}/exams/{exam_id}", status_code=status.HTTP_200_OK)
async def remove_exam_from_class(
    classroom_id: str,
    exam_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Remove an exam from a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if current_user.get("role") == "teacher" and classroom["created_by"] != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    
    db.classrooms.update_one(
        {"_id": ObjectId(classroom_id)},
        {
            "$pull": {"exam_ids": ObjectId(exam_id)},
            "$set": {"updated_at": datetime.utcnow()}
        }
    )
    
    return {"message": "Exam removed from classroom"}


@router.get("/{classroom_id}/exams")
async def get_classroom_exams(
    classroom_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Get all exams assigned to a classroom"""
    db = get_db()
    try:
        classroom = db.classrooms.find_one({"_id": ObjectId(classroom_id)})
    except Exception:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    if not classroom:
        raise HTTPException(status_code=404, detail="Classroom not found")
    
    exams = []
    for exam_id in classroom.get("exam_ids", []):
        try:
            exam = db.exams.find_one({"_id": ObjectId(exam_id)})
            if exam:
                exams.append({
                    "id": str(exam["_id"]),
                    "name": exam["name"],
                    "subject": exam.get("subject", ""),
                    "total_questions": exam.get("total_questions", 0)
                })
        except Exception:
            pass
    
    return exams
