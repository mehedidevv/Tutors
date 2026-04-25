<div align="center">

# 📚 Care Tutors

### A smart tutoring companion app powered by Firebase

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Firestore](https://img.shields.io/badge/Firestore-FF6F00?style=for-the-badge&logo=firebase&logoColor=white)](https://firebase.google.com/docs/firestore)
[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge)](LICENSE)

<br/>

> A clean, intuitive mobile app that helps tutors manage their notes efficiently — built with Flutter and powered by Firebase Authentication & Cloud Firestore.

<br/>

[Features](#-features) &nbsp;•&nbsp; [Tech Stack](#-tech-stack) &nbsp;•&nbsp; [Getting Started](#-getting-started) &nbsp;•&nbsp; [Project Structure](#-project-structure) &nbsp;•&nbsp; [Contributing](#-contributing)

</div>

---

## ✨ Features

### 🔐 Authentication
| Feature | Description |
|---|---|
| **Create Account** | Register with email and password via Firebase Authentication |
| **Login** | Secure sign-in with existing credentials |
| **Auto Session** | Stays logged in across app restarts |
| **Logout** | One-tap secure sign-out from any screen |

### 🏠 Home Screen
| Feature | Description |
|---|---|
| **Profile Info** | Displays user name and email at the top of the home screen |
| **Quick Logout** | Logout button accessible directly from the home screen |

### 📝 Notes (Cloud Firestore)
| Feature | Description |
|---|---|
| **Add Note** | Create and save new notes instantly |
| **View All Notes** | Browse all your saved notes in a clean list |
| **Real-time Sync** | Notes update in real-time using Firestore listeners |
| **Per-user Data** | Each user sees only their own notes |

---

## 🛠 Tech Stack

| Technology | Role |
|---|---|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Firebase Authentication** | User registration, login & session management |
| **Cloud Firestore** | NoSQL real-time database for storing notes |
| **Firebase Core** | Firebase SDK initialization |



## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.x or above)
- [Dart](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A [Firebase](https://console.firebase.google.com/) account

---

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/care-tutors.git
cd care-tutors
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Firebase

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project
2. Register your Android and/or iOS app
3. Download `google-services.json` and place it in `android/app/`
4. Download `GoogleService-Info.plist` and place it in `ios/Runner/` *(iOS only)*
5. Enable **Email/Password** sign-in under **Authentication → Sign-in method**
6. Create a **Cloud Firestore** database in **test mode** (for development)

### 4. Run the App

```bash
flutter run
```

---

## 📁 Project Structure

```
care_tutors/
├── lib/
│   ├── main.dart                    # App entry point & Firebase init
│   │
│   ├── screens/
│   │   ├── login_screen.dart        # Login UI
│   │   ├── register_screen.dart     # Registration UI
│   │   └── home_screen.dart         # Home screen with profile & notes
│   │
│   ├── services/
│   │   ├── auth_service.dart        # Firebase Auth logic (register/login/logout)
│   │   └── firestore_service.dart   # Firestore CRUD operations for notes
│   │
│   └── widgets/
│       └── note_card.dart           # Reusable note list item widget
│
├── android/
│   └── app/
│       └── google-services.json     # Firebase Android config
│
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist # Firebase iOS config
│
├── pubspec.yaml                     # Project dependencies
└── README.md
```

---

## 🔥 Firebase Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🗄 Firestore Data Structure

```
Firestore Database
└── users/
      └── {userId}/
            └── notes/
                  └── {noteId}/
                        ├── title      : String
                        ├── content    : String
                        └── createdAt  : Timestamp
```

Each user's notes are stored under their unique `userId`, ensuring data is private and isolated per account.

---

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how to get started:

1. **Fork** this repository
2. **Create** a feature branch
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Commit** your changes
   ```bash
   git commit -m "feat: add your feature description"
   ```
4. **Push** to your branch
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open** a Pull Request

> For major changes, please open an issue first to discuss what you'd like to change.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).  
Feel free to use, modify, and distribute this project.

---

## 📬 Contact

Have questions or suggestions? Feel free to open an [issue](https://github.com/your-username/care-tutors/issues) or reach out directly.

---

<div align="center">

Made with ❤️ by the **Care Tutors Team**

⭐ If you found this project helpful, please consider giving it a star!

</div>
