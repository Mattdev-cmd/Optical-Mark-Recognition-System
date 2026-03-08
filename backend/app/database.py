from pymongo import MongoClient
from pymongo.errors import ServerSelectionTimeoutError
from .config import settings

class MongoDBClient:
    client: MongoClient = None
    db = None

mongodb = MongoDBClient()

def connect_db():
    try:
        mongodb.client = MongoClient(settings.MONGODB_URL, serverSelectionTimeoutMS=5000)
        mongodb.db = mongodb.client[settings.DATABASE_NAME]
        print("✓ Connected to MongoDB")
        return True
    except ServerSelectionTimeoutError:
        print("✗ Failed to connect to MongoDB")
        return False

def close_db():
    if mongodb.client:
        mongodb.client.close()
        print("✓ Disconnected from MongoDB")

def get_db():
    return mongodb.db
