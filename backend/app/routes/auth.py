from fastapi import APIRouter, HTTPException, status, Depends, Body
from datetime import timedelta, datetime
from bson.objectid import ObjectId
from ..models import UserCreate, UserLogin, UserResponse
from ..utils.auth import AuthUtils, get_current_user
from ..database import get_db
from ..config import settings

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/test-login", tags=["Debug"])
async def test_login():
    """Test endpoint to verify database and authentication"""
    db = get_db()
    
    try:
        user = db.users.find_one({"email": "teacher@example.com"})
        if not user:
            return {"status": "ERROR", "message": "User not found in database"}
        
        is_valid = AuthUtils.verify_password("password123", user["password_hash"])
        
        return {
            "status": "OK",
            "user_found": True,
            "email": user["email"],
            "password_valid": is_valid,
            "is_active": user.get("is_active", True),
            "user_id": str(user["_id"])
        }
    except Exception as e:
        return {"status": "ERROR", "message": str(e)}

@router.post("/debug-request", tags=["Debug"])
async def debug_request(data: dict = Body(...)):
    """Echo back what request data is received"""
    print(f"[DEBUG REQUEST] Raw data: {data}")
    db = get_db()
    email = data.get('email', '').lower().strip()
    user = db.users.find_one({"email": email})
    
    return {
        "received_data": data,
        "email_searched": email,
        "user_found": user is not None,
        "user_email_in_db": user["email"] if user else None
    }

@router.post("/register", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def register(user_data: UserCreate):
    """Register a new user"""
    db = get_db()
    
    # Validate passwords match
    if user_data.password != user_data.confirm_password:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Passwords do not match"
        )
    
    # Check if email already exists
    existing_user = db.users.find_one({"email": user_data.email})
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    # Create user
    user_dict = user_data.dict(exclude={"confirm_password"})
    user_dict["password_hash"] = AuthUtils.hash_password(user_data.password)
    user_dict["is_active"] = True
    user_dict["created_at"] = user_dict["updated_at"] = datetime.utcnow()
    
    result = db.users.insert_one(user_dict)
    
    return UserResponse(
        id=str(result.inserted_id),
        **user_dict
    )

@router.post("/login")
async def login(credentials: UserLogin):
    """Login user"""
    db = get_db()
    
    try:
        user = db.users.find_one({"email": credentials.email})
        
        if not user:
            print(f"[LOGIN] User not found: {credentials.email}")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid email or password"
            )
        
        password_valid = AuthUtils.verify_password(credentials.password, user["password_hash"])
        
        if not password_valid:
            print(f"[LOGIN] Password mismatch for: {credentials.email}")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid email or password"
            )
        
        if not user.get("is_active", True):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="User account is inactive"
            )
        
        # Create token
        access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = AuthUtils.create_access_token(
            data={
                "sub": str(user["_id"]),
                "email": user["email"],
                "role": user["role"]
            },
            expires_delta=access_token_expires
        )
        
        print(f"[LOGIN] Success for: {credentials.email}")
        
        return {
            "access_token": access_token,
            "token_type": "bearer",
            "user": {
                "id": str(user["_id"]),
                "name": user["name"],
                "email": user["email"],
                "role": user["role"],
                "created_at": user["created_at"].isoformat(),
                "updated_at": user["updated_at"].isoformat()
            }
        }
    except HTTPException:
        raise
    except Exception as e:
        print(f"[LOGIN ERROR] {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Login error: {str(e)}"
        )

@router.get("/me", response_model=UserResponse)
async def get_current_user_info(current_user: dict = Depends(get_current_user)):
    """Get current user information"""
    db = get_db()
    
    user = db.users.find_one({"_id": ObjectId(current_user["user_id"])})
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    
    return UserResponse(
        id=str(user["_id"]),
        **user
    )
