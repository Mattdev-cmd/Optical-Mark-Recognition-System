# MongoDB Setup

## Collections Schema

### users
```json
{
  "_id": ObjectId,
  "name": String,
  "email": String (unique),
  "password_hash": String,
  "role": String, // "admin", "teacher", "student"
  "is_active": Boolean,
  "created_at": DateTime,
  "updated_at": DateTime
}
```

### exams
```json
{
  "_id": ObjectId,
  "name": String,
  "subject": String,
  "total_questions": Number,
  "choices": [String], // e.g., ["A", "B", "C", "D", "E"]
  "answer_key": [
    {
      "question_number": Number,
      "correct_answer": String
    }
  ],
  "created_by": String (user_id),
  "created_at": DateTime,
  "updated_at": DateTime
}
```

### results
```json
{
  "_id": ObjectId,
  "student_name": String,
  "exam_id": String (exam object id),
  "exam_name": String,
  "total_questions": Number,
  "correct_answers": Number,
  "score_percentage": Number,
  "student_answers": [
    {
      "question_number": Number,
      "student_answer": String (nullable),
      "correct_answer": String,
      "is_correct": Boolean
    }
  ],
  "scanned_by": String (user_id),
  "scanned_at": DateTime
}
```

## Setup Instructions

1. Install MongoDB Community Edition
2. Start MongoDB service: `mongod`
3. Create database: `db.createDatabase("omr_scanner")`
4. Create collections:
   ```
   db.createCollection("users")
   db.createCollection("exams")
   db.createCollection("results")
   ```
5. Create indexes:
   ```
   db.users.createIndex({ "email": 1 }, { unique: true })
   db.exams.createIndex({ "created_by": 1 })
   db.results.createIndex({ "exam_id": 1 })
   db.results.createIndex({ "scanned_by": 1 })
   ```
