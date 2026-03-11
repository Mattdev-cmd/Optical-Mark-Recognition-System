from pydantic import BaseModel, Field
from typing import List, Optional, Dict
from datetime import datetime
from enum import Enum

class ClassroomCreate(BaseModel):
    """Create a new classroom"""
    name: str = Field(..., min_length=1, max_length=100)
    description: Optional[str] = Field(None, max_length=500)
    section: Optional[str] = Field(None, max_length=50)  # e.g., "A", "B", "10-A"
    grade: Optional[str] = Field(None, max_length=20)  # e.g., "10", "12"
    academic_year: Optional[str] = Field(None, max_length=20)  # e.g., "2024-2025"
    max_students: Optional[int] = Field(None, gt=0)

class ClassroomUpdate(BaseModel):
    """Update classroom details"""
    name: Optional[str] = None
    description: Optional[str] = None
    section: Optional[str] = None
    grade: Optional[str] = None
    academic_year: Optional[str] = None
    max_students: Optional[int] = None

class ClassroomResponse(BaseModel):
    """Classroom response model"""
    id: str = Field(alias="_id")
    name: str
    description: Optional[str] = None
    section: Optional[str] = None
    grade: Optional[str] = None
    academic_year: Optional[str] = None
    max_students: Optional[int] = None
    created_by: Optional[str] = None  # Teacher ID
    student_count: int = 0
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class ClassroomInDB(BaseModel):
    """Classroom document in database"""
    _id: str
    name: str
    description: Optional[str] = None
    section: Optional[str] = None
    grade: Optional[str] = None
    academic_year: Optional[str] = None
    max_students: Optional[int] = None
    created_by: str  # Teacher ID
    student_ids: List[str] = []  # List of enrolled student IDs
    exam_ids: List[str] = []  # List of exams assigned to this class
    created_at: datetime
    updated_at: datetime
    is_active: bool = True


class StudentEnrollment(BaseModel):
    """Enrollment record for a student in a classroom"""
    student_id: str
    student_name: str
    enrollment_date: datetime
    roll_number: Optional[str] = None  # Optional: Roll number in class
    status: str = "active"  # active, inactive, suspended


class ClassroomWithStudents(ClassroomResponse):
    """Classroom response with enrolled students"""
    students: List[Dict] = []  # List of enrolled students with details
    total_exams: int = 0  # Exams assigned to this class
    

class StudentClassRecord(BaseModel):
    """Individual student's record in a class"""
    student_id: str
    student_name: str
    roll_number: Optional[str] = None
    classroom_id: str
    classroom_name: str
    enrollment_date: datetime
    exam_scores: Dict[str, float] = {}  # exam_id -> score_percentage
    total_exams_taken: int = 0
    average_score: float = 0.0
    last_exam_date: Optional[datetime] = None
    status: str = "active"

    class Config:
        from_attributes = True


class ClassroomStats(BaseModel):
    """Statistics for a classroom"""
    classroom_id: str
    classroom_name: str
    total_students: int
    total_exams: int
    average_class_score: float = 0.0
    highest_score: float = 0.0
    lowest_score: float = 0.0
    students_passed: int = 0  # Count with score >= 50
    pass_percentage: float = 0.0
    exam_wise_statistics: Dict[str, Dict] = {}  # Detailed stats per exam
