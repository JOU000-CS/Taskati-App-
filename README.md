# Taskati

A clean, fast, and simple task manager to help you plan your day, track progress, and get things done — built with Flutter.

---

## Table of Contents
- [Preview](#preview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Run the App](#run-the-app)
- [Build Releases](#build-releases)
- [Project Structure](#project-structure)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Preview

<!-- Replace the images below with your own screenshots or GIFs -->
<p align="center">
  <img src="assets/screenshots/1.png" alt="Taskati - Home" width="28%">
  <img src="assets/screenshots/2.png" alt="Taskati - Add Task" width="28%">
  <img src="assets/screenshots/3.png" alt="Taskati - Calendar" width="28%">
</p>

If you don’t have screenshots yet:
- Create a folder at `assets/screenshots/`
- Add images and update `pubspec.yaml` to include the assets.

## Features
- Create, edit, and delete tasks
- Due dates, times, and reminders
- Categories/tags and priorities
- Daily, weekly, and monthly views
- Search and filter
- Dark and light themes
- Offline-first data storage
- Local notifications
- Simple and responsive UI

> Note: You can edit this list to match the exact features in your build.

## Tech Stack
- Flutter (Dart)
- Platform support: Android, iOS, Web, and optionally Desktop
- Local storage: (e.g., Hive or Sqflite) — update to what you use
- Notifications: (e.g., flutter_local_notifications) — update to what you use
- State management: (e.g., Provider, Riverpod, BLoC) — update to what you use

## Getting Started

### Prerequisites
- Flutter SDK 3.x (install from: https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter/Dart extensions
- For iOS: Xcode and CocoaPods (`sudo gem install cocoapods`)
- Device/emulator/simulator set up

Verify your setup:
```bash
flutter --version
flutter doctor
```

### Clone the repository
```bash
git clone https://github.com/JOU000-CS/Taskati-App-.git
cd Taskati-App-
```

### Install dependencies
```bash
flutter pub get
```

### Configure assets (optional)
If you added images or fonts, ensure `pubspec.yaml` includes them:
```yaml
flutter:
  assets:
    - assets/screenshots/

```

## Run the App

- Android:
  ```bash
  flutter run -d android
  ```

- iOS:
  ```bash
  # First time on iOS:
  cd ios && pod install && cd ..
  flutter run -d ios
  ```


## Build Releases

- Android APK:
  ```bash
  flutter build apk --release
  ```

- Android App Bundle:
  ```bash
  flutter build appbundle --release
  ```

- iOS (requires signing):
  ```bash
  flutter build ios --release
  ```


## Project Structure
This is a typical Flutter structure. Update this to reflect your actual layout.
```
Taskati-App-/
├─ lib/
│  ├─ main.dart
│  ├─ core/           # constants, theme, utils
│  ├─ data/           # models, repositories, local db
│  ├─ features/
│  │  ├─ tasks/       # UI, state, services for tasks
│  │  ├─ calendar/
│  │  └─ settings/
│  └─ widgets/        # shared widgets
├─ assets/
│  └─ screenshots/
├─ android/
├─ ios/
├─ web/
├─ test/              # unit/widget tests
└─ pubspec.yaml
```

## Roadmap
- [ ] Recurring tasks
- [ ] Cloud sync/backup
- [ ] Attachments and notes
- [ ] Widgets/Live Activities
- [ ] Localization (AR/EN/...)
- [ ] App icon and splash customization
- [ ] CI/CD for builds

## Contributing
Contributions are welcome!  
- Open an issue to discuss changes/ideas
- Fork the repo and create a feature branch
- Make changes with clear commit messages
- Open a Pull Request with a description and screenshots if UI changes

## Contact
- Author: @JOU000-CS
- Repository: https://github.com/JOU000-CS/Taskati-App-
- Feel free to open issues for bugs or feature requests.
