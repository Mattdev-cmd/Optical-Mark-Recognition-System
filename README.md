# OMR Exam Scanner - Complete Setup Guide

## Project Overview
A comprehensive solution for scanning exam answer sheets and automatically calculating scores using Optical Mark Recognition (OMR) technology.

### Tech Stack
- **Backend**: FastAPI (Python)
- **Mobile**: Flutter
- **Image Processing**: OpenCV
- **Database**: MongoDB
- **Authentication**: JWT Tokens
- **Server**: Uvicorn

---

## Project Structure

```
Project_OMR/
├── backend/              # FastAPI backend
│   ├── app/
│   │   ├── routes/      # API endpoints
│   │   ├── models/      # Pydantic models
│   │   ├── processing/  # OMR processing logic
│   │   ├── utils/       # Utilities (auth, helpers)
│   │   ├── middleware/  # Middleware
│   │   ├── config.py    # Configuration
│   │   └── database.py  # Database connection
│   ├── main.py          # Entry point
│   └── requirements.txt  # Dependencies
├── mobile/              # Flutter mobile app
│   └── omr_scanner/
│       ├── lib/
│       │   ├── screens/     # UI screens
│       │   ├── models/      # Data models
│       │   ├── services/    # API client
│       │   ├── providers/   # State management
│       │   ├── widgets/     # Reusable widgets
│       │   └── main.dart    # Entry point
│       └── pubspec.yaml     # Dependencies
├── database/            # MongoDB setup
├── docs/                # Documentation
└── .github/             # Configuration files
```

---

## Backend Setup

### 1. Prerequisites
- Python 3.10+
- pip
- MongoDB running locally or remote connection

### 2. Installation

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 3. Environment Configuration

Create `.env` file in backend directory:

```env
# Server
HOST=0.0.0.0
PORT=8000
DEBUG=True

# Database
MONGODB_URL=mongodb://localhost:27017
DATABASE_NAME=omr_scanner

# JWT
SECRET_KEY=your-secret-key-change-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# Files
UPLOAD_DIR=./uploads

# OMR Processing
MIN_BUBBLE_FILL_RATIO=0.4
BUBBLE_DETECTION_THRESHOLD=150
```

### 4. Database Setup

#### MongoDB Local Installation
```bash
# Windows (using Chocolatey)
choco install mongodb4.4
mongod

# macOS (using Homebrew)
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community

# Linux (Ubuntu/Debian)
sudo apt-get install -y mongodb
sudo systemctl start mongodb
```

#### MongoDB Cloud (Atlas)
1. Go to https://www.mongodb.com/cloud/atlas
2. Create account and cluster
3. Copy connection string
4. Update `MONGODB_URL` in `.env`

### 5. Initialize Database

```bash
# Collections will be created automatically on first insert
# Or manually run seed script if provided
python -c "from app.database import connect_db; connect_db()"
```

### 6. Run Backend

```bash
# Using uvicorn directly
uvicorn main:app --reload

# Or using Python
python main.py
```

Server will be available at: `http://localhost:8000`

API Documentation: `http://localhost:8000/docs` (Swagger UI)

---

## Mobile Setup

### 1. Prerequisites
- Flutter SDK (3.0.0+)
- Android Studio or Xcode
- Android SDK 21+ or iOS 11+

### 2. Installation

```bash
cd mobile/omr_scanner

# Get Flutter packages
flutter pub get

# Generate code (for freezed, json_serializable, etc.)
flutter pub run build_runner build
```

### 3. Configuration

Update `lib/services/api_client.dart` with your backend URL:

```dart
static const String baseUrl = "http://localhost:8000"; // Change as needed
```

### 4. Run Mobile App

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web (experimental)
flutter run -d web
```

---

## Features & Functionalities

### 1. User Authentication
- **Registration**: Create new user account with email and password
- **Login**: Secure login with JWT token generation
- **Roles**: Admin, Teacher, Student roles
- **Session Management**: Automatic token refresh and validation

**API Endpoints**:
- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user
- `GET /auth/me` - Get current user info

### 2. Exam Management
- **Create Exam**: Define exam with questions and answer key
- **List Exams**: View all created exams
- **Edit Exam**: Update exam details and answer key
- **Delete Exam**: Remove exam from system

**API Endpoints**:
- `POST /exams/create` - Create new exam
- `GET /exams` - Get all exams
- `GET /exams/{exam_id}` - Get exam details
- `PUT /exams/{exam_id}` - Update exam
- `DELETE /exams/{exam_id}` - Delete exam

### 3. Answer Sheet Scanning
The core OMR functionality:

1. **Image Capture**: Take photo of answer sheet
2. **Image Preprocessing**: 
   - Grayscale conversion
   - Contrast enhancement (CLAHE)
   - Bilateral filtering
   - Otsu's thresholding

3. **Sheet Alignment**:
   - Detect corner markers/boundaries
   - Apply perspective transformation
   - Straighten tilted images

4. **Bubble Detection**:
   - Detect circular answer bubbles
   - Filter by size and circularity
   - Group by question and choice
   - Calculate fill ratio for each bubble

5. **Answer Recognition**:
   - Compare bubble fill ratios
   - Identify selected choice (>40% fill threshold)
   - Extract final answers

6. **Score Calculation**:
   - Compare with answer key
   - Calculate correct answers
   - Compute percentage

**API Endpoints**:
- `POST /scan/process-sheet` - Process answer sheet image
- `GET /scan/results/{exam_id}` - Get exam results
- `GET /scan/result/{result_id}` - Get detailed result

### 4. Results Management
- **View Results**: See student scores and answers
- **Result Details**: Detailed question-by-question breakdown
- **Analytics**: Score distribution and statistics

---

## OMR Processing Details

### Bubble Detection Algorithm

1. **Preprocessing**:
   - Apply CLAHE for contrast enhancement
   - Use bilateral filtering to reduce noise
   - Apply Otsu's thresholding for binary image

2. **Contour Detection**:
   - Find all contours in image
   - Filter by area and circularity (>0.6)
   - Keep circular contours (bubbles)

3. **Grouping**:
   - Sort by Y-coordinate (rows = questions)
   - Sort by X-coordinate (columns = choices)
   - Group into question-choice pairs

4. **Fill Ratio Calculation**:
   - Calculate contour area
   - Count filled pixels within contour
   - Fill ratio = filled pixels / total area

5. **Answer Selection**:
   - Find bubble with highest fill ratio
   - If fill > MIN_BUBBLE_FILL_RATIO (0.4), mark as selected
   - Otherwise, mark as no answer

### Configuration Parameters

```python
MIN_BUBBLE_FILL_RATIO = 0.4      # Minimum 40% fill to count as selected
BUBBLE_DETECTION_THRESHOLD = 150  # Binary threshold value
MIN_BUBBLE_SIZE = 100 pixels      # Minimum bubble area
MAX_BUBBLE_SIZE = 5000 pixels     # Maximum bubble area
BUBBLE_CIRCULARITY = 0.6          # Minimum circularity coefficient
```

---

## API Documentation

### Authentication Endpoint

#### Register
```http
POST /auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securepass123",
  "confirm_password": "securepass123",
  "role": "teacher"
}

Response: 201 Created
{
  "id": "507f1f77bcf86cd799439011",
  "name": "John Doe",
  "email": "john@example.com",
  "role": "teacher",
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-15T10:30:00Z"
}
```

#### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "securepass123"
}

Response: 200 OK
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer",
  "user": {
    "id": "507f1f77bcf86cd799439011",
    "name": "John Doe",
    "email": "john@example.com",
    "role": "teacher"
  }
}
```

### Exam Endpoints

#### Create Exam
```http
POST /exams/create
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Math Quiz 1",
  "subject": "Mathematics",
  "total_questions": 20,
  "choices": ["A", "B", "C", "D", "E"],
  "answer_key": [
    {"question_number": 1, "correct_answer": "A"},
    {"question_number": 2, "correct_answer": "C"},
    ...
  ]
}

Response: 201 Created
{
  "id": "507f1f77bcf86cd799439012",
  "name": "Math Quiz 1",
  "subject": "Mathematics",
  "total_questions": 20,
  "choices": ["A", "B", "C", "D", "E"],
  "answer_key": [...],
  "created_by": "507f1f77bcf86cd799439011",
  "created_at": "2024-01-15T10:35:00Z",
  "updated_at": "2024-01-15T10:35:00Z"
}
```

### Scanning Endpoint

#### Process Answer Sheet
```http
POST /scan/process-sheet
Authorization: Bearer {token}
Content-Type: multipart/form-data

Form Data:
- exam_id: "507f1f77bcf86cd799439012"
- student_name: "Juan Dela Cruz"
- sheet_image: (binary image file)

Response: 200 OK
{
  "result_id": "507f1f77bcf86cd799439013",
  "student_name": "Juan Dela Cruz",
  "exam_name": "Math Quiz 1",
  "total_questions": 20,
  "correct_answers": 18,
  "score": "18/20",
  "percentage": "90.00%",
  "student_answers": [
    {
      "question_number": 1,
      "student_answer": "A",
      "correct_answer": "A",
      "is_correct": true
    },
    ...
  ],
  "metadata": {
    "total_bubbles_detected": 100,
    "questions_processed": 20,
    "confidence_scores": {...}
  }
}
```

---

## Testing

### Backend Testing

```bash
# Create test user
curl -X POST "http://localhost:8000/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "test123",
    "confirm_password": "test123",
    "role": "teacher"
  }'

# Login
curl -X POST "http://localhost:8000/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "test123"
  }'

# Create exam
curl -X POST "http://localhost:8000/exams/create" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{...}'
```

### Mobile Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage

# Build APK
flutter build apk

# Build iOS
flutter build ios
```

---

## Deployment

### Backend Deployment (Docker)

Create `Dockerfile`:
```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

Build and run:
```bash
docker build -t omr-backend .
docker run -p 8000:8000 -e MONGODB_URL=... omr-backend
```

### Mobile Deployment

```bash
# Android Release
flutter build apk --release

# iOS Release
flutter build ios --release

# Build and publish to stores
flutter pub pub publish
```

---

## Troubleshooting

### Common Issues

1. **MongoDB Connection Error**
   - Ensure MongoDB is running: `mongod`
   - Check connection string in `.env`
   - Verify firewall settings

2. **Image Processing Issues**
   - Ensure good lighting when scanning
   - Use high-quality answer sheets
   - Check OpenCV installation: `python -c "import cv2; print(cv2.__version__)"`

3. **CORS Issues**
   - CORS is already enabled for all origins in backend
   - Update frontend URL if needed in main.py

4. **JWT Token Errors**
   - Check SECRET_KEY is set and consistent
   - Verify token not expired (30 min default)
   - Ensure proper Authorization header format

---

## Security Considerations

1. **Environment Variables**: Keep SECRET_KEY safe, don't commit to repo
2. **Password Hashing**: Using bcrypt with salt
3. **Token Expiration**: 30 minutes default
4. **HTTPS**: Use in production
5. **Input Validation**: All inputs validated with Pydantic
6. **CORS**: Restrict to specific domains in production

---

## Performance Optimization

1. **Image Processing**:
   - Resize large images before processing
   - Use threading for heavy operations
   - Implement caching for repeated exams

2. **Database**:
   - Add indexes on frequently queried fields
   - Use pagination for large result sets
   - Implement caching layer (Redis)

3. **API**:
   - Use connection pooling
   - Compress responses
   - Implement rate limiting

---

## Next Steps

1. Set up Firebase Authentication (optional)
2. Implement result analytics and dashboards
3. Add batch processing for multiple sheets
4. Build export/report generation features
5. Implement answer sheet templates
6. Add mobile offline capability
7. Integrate with school management systems

---

## Support & Documentation

- **API Documentation**: http://localhost:8000/docs
- **OpenCV Docs**: https://docs.opencv.org/
- **FastAPI Docs**: https://fastapi.tiangolo.com/
- **Flutter Docs**: https://flutter.dev/docs
- **MongoDB Docs**: https://docs.mongodb.com/

---

## License

This project is provided as-is for educational and commercial use.

---

**Last Updated**: January 2024
**Version**: 1.0.0
