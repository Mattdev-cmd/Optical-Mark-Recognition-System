#!/usr/bin/env python3
"""
Setup script to create a test user in MongoDB for development
"""
import sys
from pymongo import MongoClient
from app.utils.auth import AuthUtils
from app.config import settings
from datetime import datetime

def create_test_user():
    """Create a test user for development"""
    try:
        # Connect to MongoDB
        client = MongoClient(settings.MONGODB_URL, serverSelectionTimeoutMS=5000)
        db = client[settings.DATABASE_NAME]
        
        print("✓ Connected to MongoDB")
        
        # Test user data
        test_user = {
            "name": "Test Teacher",
            "email": "teacher@example.com",
            "password_hash": AuthUtils.hash_password("password123"),
            "role": "teacher",
            "is_active": True,
            "created_at": datetime.utcnow(),
            "updated_at": datetime.utcnow()
        }
        
        # Check if user already exists
        existing = db.users.find_one({"email": test_user["email"]})
        if existing:
            print(f"✓ Test user already exists: {test_user['email']}")
            client.close()
            return True
        
        # Insert test user
        result = db.users.insert_one(test_user)
        print(f"✓ Test user created successfully!")
        print(f"  Email: {test_user['email']}")
        print(f"  Password: password123")
        print(f"  Role: {test_user['role']}")
        print(f"  User ID: {result.inserted_id}")
        
        client.close()
        return True
        
    except Exception as e:
        print(f"✗ Error: {e}")
        print(f"✗ Make sure MongoDB is running at {settings.MONGODB_URL}")
        return False

if __name__ == "__main__":
    success = create_test_user()
    sys.exit(0 if success else 1)
