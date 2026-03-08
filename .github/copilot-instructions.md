# OMR Exam Scanner - Development Guidelines

## Project Overview
A comprehensive OMR (Optical Mark Recognition) system for scanning and scoring exam answer sheets. Full-stack application with FastAPI backend and Flutter mobile client.

## Technology Stack
- **Backend**: FastAPI (Python 3.10+)
- **Frontend**: Flutter (Dart)
- **Image Processing**: OpenCV
- **Database**: MongoDB
- **Authentication**: JWT
- **Server**: Uvicorn

## Project Structure
```
Project_OMR/
├── backend/
│   ├── app/
│   │   ├── routes/          # API endpoints
│   │   ├── models/          # Pydantic models
│   │   ├── processing/      # OMR processing logic
│   │   ├── utils/           # Auth and utilities
│   │   ├── middleware/      # Middleware
│   │   ├── config.py        # Configuration
│   │   └── database.py      # Database
│   └── main.py              # Entry point
├── mobile/omr_scanner/
│   └── lib/
│       ├── screens/         # UI screens
│       ├── models/          # Data models
│       ├── services/        # API client
│       └── main.dart        # Entry point
├── database/                # MongoDB setup
├── docs/                    # Documentation
└── README.md                # Full documentation
```

## Key Components

### Backend
1. **Authentication** (`routes/auth.py`)
   - User registration with validation
   - JWT-based login
   - Role-based access control

2. **Exam Management** (`routes/exams.py`)
   - Create/edit/delete exams
   - Answer key management
   - Exam listing and filtering

3. **OMR Processing** (`processing/omr_processor.py`)
   - Image preprocessing
   - Sheet alignment (perspective transformation)
   - Bubble detection
   - Answer extraction
   - Score calculation

4. **Results Tracking** (`routes/scanning.py`)
   - Process answer sheets
   - Store results
   - Retrieve analytics

### Mobile
1. **Authentication Screens** (`screens/login_screen.dart`, `register_screen.dart`)
2. **Dashboard** (`screens/dashboard_screen.dart`)
3. **Scanning Interface** (`screens/scan_screen.dart`)
4. **Results Display** (`screens/results_screen.dart`)
5. **API Client** (`services/api_client.dart`)
6. **Data Models** (`models/`)

## Development Standards

### Python (Backend)
- Use type hints for all functions
- Follow PEP 8 style guide
- Implement comprehensive error handling
- Add docstrings to functions and classes
- Use async/await for I/O operations

### Dart/Flutter (Mobile)
- Use freezed for immutable models
- Implement proper state management
- Follow Material Design principles
- Add null safety throughout
- Use provider for state if needed

## API Design
- RESTful endpoints with clear naming
- Consistent error responses
- Proper HTTP status codes
- Bearer token authentication
- Form data for file uploads

## Image Processing Pipeline
1. Load image from bytes
2. Preprocess (grayscale, CLAHE, bilateral filter, threshold)
3. Align sheet (perspective transformation)
4. Detect bubbles (contour detection, filtering)
5. Group bubbles (by question and choice)
6. Calculate fill ratios
7. Extract answers and score

## Configuration
- Use environment variables for sensitive data
- Default configuration in `app/config.py`
- Example `.env` file in `.env.example`

## Testing
- Backend: Use pytest with FastAPI TestClient
- Mobile: Use Flutter test framework
- Manual testing with API documentation

## Security Considerations
- Validate all user inputs
- Hash passwords with bcrypt
- Use JWT for stateless authentication
- Implement CORS properly
- Sanitize file uploads
- Use HTTPS in production

## Common Tasks

### Adding New Exam Features
1. Update Pydantic model in `models/exam.py`
2. Add route in `routes/exams.py`
3. Update MongoDB collection schema
4. Update Flutter models in `lib/models/exam_model.dart`
5. Update API client in `lib/services/api_client.dart`

### Improving OMR Detection
1. Adjust parameters in `OMRProcessor.__init__()`
2. Modify preprocessing in `_preprocess_image()`
3. Tune bubble detection in `_detect_bubbles()`
4. Test with sample images

### Adding New Screen
1. Create new Dart file in `lib/screens/`
2. Add navigation route in `main.dart`
3. Implement screen UI and logic
4. Add to bottom/top navigation if needed

## Dependencies Management

### Backend
- Update `requirements.txt` with version pins
- Run `pip install -r requirements.txt --upgrade` sparingly
- Test before committing major version changes

### Mobile
- Update `pubspec.yaml` for new packages
- Run `flutter pub get`
- Run `flutter pub run build_runner build` after adding generators

## Database
- MongoDB collections auto-created on first insert
- Indexes for performance: see `database/SETUP.md`
- Regular backups in production

## Performance Optimization
- Cache frequently accessed data
- Use pagination for large result sets
- Optimize image processing (resize before processing)
- Implement lazy loading in mobile app
- Use connection pooling for database

## Error Handling
- Comprehensive try-catch in async operations
- Meaningful error messages
- Proper HTTP status codes
- Log errors for debugging

## Documentation
- Keep README.md up to date
- Document API endpoints
- Comment complex algorithms
- Maintain this guidelines file

## To Get Started
1. Follow setup in QUICKSTART.md
2. Create `.env` file from `.env.example`
3. Start MongoDB: `mongod`
4. Run backend: `python main.py`
5. Run mobile: `flutter run`
6. Test with API docs: http://localhost:8000/docs

## Useful Commands

### Backend
```bash
cd backend
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
python main.py
```

### Mobile
```bash
cd mobile/omr_scanner
flutter pub get
flutter pub run build_runner build
flutter run
```

### Database
```bash
mongod  # Start MongoDB
mongo   # Connect to MongoDBI've successfully created your complete OMR Exam Scanner application! Here's a summary of what's been set up:

## ✅ Project Setup Complete

### Backend (FastAPI)
- **Full authentication system** with JWT tokens and role-based access
- **Exam management** (create, read, update, delete)
- **OMR Processing Engine** with:
  - Image preprocessing (CLAHE, bilateral filtering)
  - Sheet alignment using perspective transformation
  - Bubble detection with circularity filtering
  - Answer extraction and scoring
- **Results management and tracking**
- **Comprehensive error handling**

### Mobile App (Flutter)
- **5 main screens**: Login, Register, Dashboard, Scanning, Results
- **Freezed models** for type-safe data handling
- **API client** for seamless backend communication
- **Modern Material Design UI**
- **Proper navigation structure**

### Database
- **MongoDB collection schemas** for users, exams, and results
- **Setup instructions** for local and cloud deployment
- **Index recommendations** for performance

### Documentation
- **Complete README.md** with 500+ lines covering:
  - Full setup guide
  - Feature documentation
  - API endpoints with examples
  - OMR algorithm details
  - Troubleshooting guide
  - Deployment instructions

- **QUICKSTART.md** for rapid development setup
- **Database setup guide**
- **Environment examples**

## 🎯 Key Features Implemented

1. ✅ **User Authentication** - Register/Login with role support
2. ✅ **Exam Management** - Full CRUD operations
3. ✅ **OMR Scanning** - Advanced image processing
4. ✅ **Score Calculation** - Automatic grading
5. ✅ **Results Tracking** - Detailed analytics

## 🚀 Next Steps

1. **Start the backend**:
```bash
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python main.py
```

2. **Start MongoDB**:
```bash
mongod
```

3. **Run the mobile app**:
```bash
cd mobile/omr_scanner
flutter pub get
flutter run
```

4. **Test the API** at: `http://localhost:8000/docs`

All files are properly configured and ready to use. The project follows industry best practices with clean architecture, comprehensive error handling, and production-ready code structure.
