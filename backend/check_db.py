from pymongo import MongoClient
from bson.json_util import dumps

client = MongoClient('mongodb://localhost:27017')
db = client['omr_scanner']

print("=== Users ===")
users = list(db.users.find())
for user in users:
    print(f"Email: {user.get('email')}, ID: {user.get('_id')}")

print("\n=== Exams ===")
exams = list(db.exams.find())
print(f"Total exams: {len(exams)}")

for exam in exams:
    print(f"\nExam: {exam.get('name')}")
    print(f"  ID: {exam.get('_id')}")
    print(f"  Created By: {exam.get('created_by')}")
    print(f"  Total Questions: {exam.get('total_questions')}")
    print(f"  Fields: {list(exam.keys())}")
