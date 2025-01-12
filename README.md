# 🏃‍♂️ Running App

A full-stack mobile application for fitness enthusiasts that tracks running activities, builds community engagement, and rewards users with a point-based shopping system. Built with Django REST Framework and Flutter.

## 🛠️ Technologies Used

- Backend:
  - 🐍 Django REST Framework
  - 🐬 MySQL
  - 🚀 Python 3.x

- Frontend:
  - 💙 Flutter
  - 🎯 Dart

- Maps & Location:
  - 🗺️ Google Maps API
  - 📍 GPS Integration

## 🚀 Getting Started

### Backend Setup

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Run migrations:
```bash
python manage.py migrate
```

4. Start the server:
```bash
python manage.py runserver
```

### Flutter Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## 📱 Features

- 🔐 User Authentication & Profiles
- 📊 Activity Tracking
  - Real-time distance tracking via Google Maps
  - Speed monitoring
  - Time tracking
  - Calorie consumption calculation

- 👥 Community Features
  - Share daily activities
  - Connect with other runners
  - Social feed
  - Activity comments and likes

- 🎁 Rewards System
  - Earn points through running activities
  - In-app store with redeemable products
  - Point history and transaction tracking

- 📈 Performance Analytics
  - Running history
  - Progress tracking
  - Personal records
  - Achievement badges

