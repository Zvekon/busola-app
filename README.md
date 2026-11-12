# Busola App

Busola App is a Flutter application for practicing sailing theory and taking a
timed knowledge test. The app works offline: questions and the application
interface are bundled with the app, so no backend or account is required.

## Features

- **Test** — answer 75 randomly selected questions in 90 minutes.
- **Training** — choose the number of questions for each subject and practice
  at your own pace.
- **Instant feedback** in training mode and a results summary after the test.
- Question banks covering:
  - rescue
  - yacht construction
  - sailing theory
  - navigation
  - inland-waterway regulations
  - meteorology

## Requirements

- Flutter SDK using Dart `>=3.0.6 <4.0.0`
- A configured Flutter target device or emulator

Check the local installation with:

```bash
flutter doctor
```

## Getting started

Clone the repository, install dependencies, and run the app:

```bash
git clone https://github.com/Zvekon/busola-app.git
cd busola-app
flutter pub get
flutter run
```

To select a specific device:

```bash
flutter devices
flutter run -d <device-id>
```

The project includes Flutter targets for Android, iOS, macOS, Linux, Windows,
and web. Some targets require their platform-specific toolchains; for example,
iOS and macOS builds require Xcode, while Windows builds require Visual Studio
with desktop development support.

## Using the app

1. Open **Test** to start the 75-question exam. Each question is selected
   randomly from the bundled subject banks.
2. The exam has a 90-minute countdown. You can finish it early with
   **Zakończ test** or leave after confirming.
3. Open **Trening** to choose how many questions to practice from each subject.
4. Start the training session and answer questions one at a time. Questions
   are shuffled across the selected subjects.

The interface is currently in Polish.

## Development

Run static analysis and tests with:

```bash
flutter analyze
flutter test
```

Run the application in a browser:

```bash
flutter run -d chrome
```

Create a release build for a target platform with the corresponding Flutter
command, for example:

```bash
flutter build web
flutter build apk
```

## Project structure

```text
lib/
├── main.dart                    # Application entry point and routes
├── home/                        # Home screen and mode selection
├── test/                        # Timed test flow and results
├── trening/                     # Practice flow
├── ui/                          # Shared controls
└── assets/
    ├── images/                  # Branding and background assets
    └── questions/               # JSON question banks
test/                            # Flutter widget tests
```

Question data is stored in `lib/assets/questions/` and registered as a Flutter
asset directory in `pubspec.yaml`. Each question bank is a JSON array with
objects containing `question`, `answers`, and `correctAnswer` fields. When
adding or editing questions, keep that shape and run `flutter test` before
committing.

## License

No license file is currently included in this repository. Add a license before
redistributing the application or its question content.
