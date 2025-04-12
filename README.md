# Placement-Act-Cell

A Flutter-based mobile application for managing placement activities. This application facilitates communication between students, placement officers, and companies, providing a seamless platform for job opportunities, events, and notifications.

## Features

### Student Features
- **Authentication**
  - Secure login and registration
  - Profile management
  - Password recovery

- **Dashboard**
  - View upcoming placement events
  - Browse available job opportunities
  - Real-time notifications for new opportunities
  - Event calendar and details

- **Job Portal**
  - Browse and search job listings
  - Apply for positions
  - Track application status
  - View company profiles

- **Notifications**
  - Real-time updates for new jobs
  - Event reminders
  - Application status updates
  - Customizable notification preferences

### TPO (Training & Placement Officer) Features
- **Dashboard**
  - Manage student profiles
  - Post job opportunities
  - Schedule events
  - Track applications

- **Company Management**
  - Add/Edit company profiles
  - Manage job postings
  - Track company interactions
  - Schedule interviews

- **Analytics**
  - Placement statistics
  - Student performance metrics
  - Company engagement analytics

## Screenshots and Snapshots

### Student Interface
1. **Login Screen**
   - Clean and intuitive login interface
   - Email and password authentication
   - Registration and forgot password options

2. **Home Dashboard**
   - Upcoming events carousel
   - Recent job opportunities
   - Quick access to profile and notifications

3. **Job Portal**
   - List of available positions
   - Detailed job descriptions
   - Application submission form

4. **Profile Page**
   - Personal information
   - Academic details
   - Application history

### TPO Interface
1. **Admin Dashboard**
   - Overview of placements
   - Quick actions for job posting
   - Event management

2. **Student Management**
   - Student profiles
   - Application tracking
   - Performance metrics

3. **Company Portal**
   - Company profiles
   - Job posting interface
   - Interview scheduling

4. **Analytics Dashboard**
   - Placement statistics
   - Student performance charts
   - Company engagement metrics

## Technical Stack

- **Frontend**: Flutter
- **Backend**: Firebase
  - Authentication: Firebase Auth
  - Database: Cloud Firestore
  - Storage: Firebase Storage
  - Notifications: Firebase Cloud Messaging

## Prerequisites

- Flutter SDK (>=3.1.5)
- Dart SDK (>=3.1.5)
- Android Studio / VS Code
- Firebase account
- Git

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/placementactcell.git
cd placementactcell
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and add the configuration files:
     - Android: `google-services.json` to `android/app/`
     - iOS: `GoogleService-Info.plist` to `ios/Runner/`

4. Run the application:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── student_login.dart        # Student authentication
├── student_home_page.dart    # Student dashboard
├── job_page.dart            # Job listings
├── notification.dart        # Notification management
├── services/
│   └── notification_service.dart  # Notification service
└── ...
```

## Configuration

### Firebase Setup
1. Create a new Firebase project
2. Enable Authentication (Email/Password)
3. Set up Firestore Database
4. Configure Cloud Storage
5. Set up Cloud Messaging for notifications

### Environment Variables
Create a `.env` file in the root directory with the following variables:
```
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_auth_domain
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
FIREBASE_MESSAGING_SENDER_ID=your_messaging_sender_id
FIREBASE_APP_ID=your_app_id
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Development Guidelines

- Follow Flutter's official style guide
- Write clean, documented code
- Use meaningful variable and function names
- Implement proper error handling
- Write unit tests for critical functionality
- Follow the existing project structure

## Security

- All sensitive data is stored securely in Firebase
- Authentication is handled through Firebase Auth
- API keys and credentials are stored in environment variables
- Regular security audits are performed

## Acknowledgments

- Flutter Team
- Firebase Team
- All contributors to this project
