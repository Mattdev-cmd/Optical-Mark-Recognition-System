#!/usr/bin/env python3
"""
Create test user with exact same hashing method as backend
"""
from pymongo import MongoClient
from passlib.context import CryptContext
from datetime import datetime

def create_test_user():
    """Create a test user using backend's password context"""
    try:
        # Connect
        client = MongoClient('mongodb://localhost:27017')
        db = client['omr_scanner']
        
        # Use EXACT same hashing as backend
        pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
        
        # Delete old test user if exists
        db.users.delete_one({"email": "teacher@example.com"})
        
        # Create new user
        test_user = {
            "name": "Test Teacher",
            "email": "teacher@example.com",
            "password_hash": pwd_context.hash("password123"),  # Same method as backend
            "role": "teacher",
            "is_active": True,
            "created_at": datetime.utcnow(),
            "updated_at": datetime.utcnow()
        }
        
        result = db.users.insert_one(test_user)
        
        print("✓ Test user created with backend password hashing!")
        print(f"  Email: teacher@example.com")
        print(f"  Password: password123")
        print(f"  Hash: {test_user['password_hash']}")
        print(f"  ID: {result.inserted_id}")
        
        # Verify
        verify = pwd_context.verify("password123", test_user['password_hash'])
        print(f"  Verification: {verify}")
        
        return True
        
    except Exception as e:
        print(f"✗ Error: {e}")
        return False

if __name__ == "__main__":
    create_test_user()
