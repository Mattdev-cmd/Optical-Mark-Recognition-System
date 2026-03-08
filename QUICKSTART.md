# OMR Scanner - Quick Start Guide

##  Quick Setup (5 minutes)

### Step 1: Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate
# Or (macOS/Linux)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
copy .env.example .env

# Run backend
python main.py
```

Backend will run at: **http://localhost:8000**

### Step 2: Mobile Setup

```bash
cd mobile/omr_scanner

# Get Flutter packages
flutter pub get

# Generate build files
flutter pub run build_runner build

# Run app
flutter run
```

---

##  System Requirements

- **Python 3.10+**
- **Flutter 3.0.0+**
- **MongoDB 4.4+**
- **Node.js 14+** (optional, for web)

---

##  Configuration

### Backend (.env)
```env
MONGODB_URL=mongodb://localhost:27017
SECRET_KEY=your-secret-key-here
PORT=8000
```

### Mobile (lib/services/api_client.dart)
```dart
static const String baseUrl = "http://localhost:8000";
```

---

##  Test the Application

1. **Register User**
   ```
   POST http://localhost:8000/auth/register
   ```

2. **Create Exam**
   ```
   POST http://localhost:8000/exams/create
   ```

3. **Scan & Process**
   ```
   POST http://localhost:8000/scan/process-sheet
   ```

Full documentation: See `README.md`

---

##  Key Features

✅ User Authentication (Register/Login)
✅ Exam Management (Create/Edit/Delete)
✅ OMR Sheet Scanning
✅ Automatic Score Calculation
✅ Results Management
✅ Mobile App Integration

---

##  Troubleshooting

**MongoDB not connecting?**
- Ensure MongoDB is running: `mongod`
- Check MONGODB_URL in .env

**Flutter packages not found?**
- Run: `flutter clean && flutter pub get`

**Image processing errors?**
- Ensure OpenCV is installed: `pip install opencv-python`

---

##  Documentation

- Full Setup Guide: [README.md](README.md)
- API Documentation: http://localhost:8000/docs
- Database Schema: [database/SETUP.md](database/SETUP.md)

---

##  Security Notes

- Change SECRET_KEY before production
- Use HTTPS in production
- Store credentials securely
- Enable CORS restrictions for production

---

##  Support

For issues or questions, check:
1. Full README.md
2. API Documentation at /docs
3. Backend logs for errors
4. Flutter console for mobile issues

---

**Happy Scanning! **
