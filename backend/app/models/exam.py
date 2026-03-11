from pydantic import BaseModel, Field
from typing import List, Dict, Optional
from datetime import datetime

class AnswerKey(BaseModel):
    question_number: int
    correct_answer: str = Field(..., min_length=1, max_length=1)

class ExamCreate(BaseModel):
    name: str = Field(..., min_length=1, max_length=200)
    subject: str = Field(..., min_length=1, max_length=100)
    total_questions: int = Field(..., gt=0, le=200)
    choices: List[str] = Field(default=["A", "B", "C", "D"])
    answer_key: List[AnswerKey]

class ExamUpdate(BaseModel):
    name: Optional[str] = None
    subject: Optional[str] = None
    total_questions: Optional[int] = None
    answer_key: Optional[List[AnswerKey]] = None

class ExamResponse(BaseModel):
    id: str
    name: str
    subject: Optional[str] = None
    total_questions: int
    choices: List[str]
    answer_key: List[Dict]  # Store as dict since it comes from MongoDB
    created_by: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class ExamInDB(BaseModel):
    _id: str
    name: str
    subject: str
    total_questions: int
    choices: List[str]
    answer_key: List[Dict]
    created_by: str
    created_at: datetime
    updated_at: datetime
