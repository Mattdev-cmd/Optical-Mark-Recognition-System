#!/usr/bin/env python3
"""
Standalone setup script to create a test user in MongoDB
"""
import sys
sys.path.insert(0, '.')

def create_test_user():
    """Create a test user for development"""
    try:
        from pymongo import MongoClient
        import bcrypt
        from datetime import datetime
        
        # Connect to MongoDB
        client = MongoClient('mongodb://localhost:27017', serverSelectionTimeoutMS=5000)
        db = client['omr_db']
        
        print("✓ Connected to MongoDB")
        
        # Test user data
        test_user = {
            "name": "Test Teacher",
            "email": "teacher@example.com",
            "password_hash": bcrypt.hashpw("password123".encode('utf-8'), bcrypt.gensalt()).decode('utf-8'),
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
        print(f"✗ Make sure MongoDB is running at mongodb://localhost:27017")
        return False

if __name__ == "__main__":
    success = create_test_user()
    sys.exit(0 if success else 1)
