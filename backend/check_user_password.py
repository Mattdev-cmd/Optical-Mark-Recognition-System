from pymongo import MongoClient
from bson.objectid import ObjectId
from app.utils.auth import AuthUtils
from app.config import settings

# Connect to MongoDB
client = MongoClient(settings.MONGODB_URL)
db = client[settings.DATABASE_NAME]

# Check the gelo user
user = db.users.find_one({"email": "gelo@example.com"})
if user:
    print(f"User found: {user['email']}")
    print(f"Password hash: {user['password_hash'][:50]}...")
    
    # Try to verify password
    is_valid = AuthUtils.verify_password("password123", user["password_hash"])
    print(f"Password 'password123' is valid: {is_valid}")
else:
    print("User not found")
