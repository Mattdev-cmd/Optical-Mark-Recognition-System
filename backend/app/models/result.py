from pydantic import BaseModel, Field
from typing import List, Dict, Optional
from datetime import datetime

class StudentAnswer(BaseModel):
    question_number: int
    student_answer: Optional[str] = None
    correct_answer: str
    is_correct: bool

class ResultCreate(BaseModel):
    student_name: str
    exam_id: str
    student_answers: List[StudentAnswer]

class ResultResponse(BaseModel):
    id: str = Field(alias="_id")
    student_name: str
    exam_id: str
    exam_name: str
    total_questions: int
    correct_answers: int
    score_percentage: float
    student_answers: List[StudentAnswer]
    scanned_at: datetime

    class Config:
        from_attributes = True

class ResultInDB(BaseModel):
    _id: str
    student_name: str
    exam_id: str
    exam_name: str
    total_questions: int
    correct_answers: int
    score_percentage: float
    student_answers: List[Dict]
    scanned_at: datetime
