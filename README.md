# 🍋 lemonaide

[started during [cseed](https://www.cseed.co/buildher-team) BuildHER Launchpad Cohort 0] \
\
💵 gamified financial literacy assistant for kids (ages 5–12) and parents. \
🐷 kids track earnings, set savings goals, learn through an AI coach, unlock progress rewards, etc.


## Run locally

Requires [Flutter](https://docs.flutter.dev/get-started/install) SDK ≥ 3.5.

```bash
cd lemonaide
flutter pub get
flutter run -d macos   # or chrome, ios, android
```

**Hot reload:** click the terminal running `flutter run`, then press `r`. Press `R` for a full restart (needed after asset changes).

## Stack

Flutter · Riverpod · GoRouter · Google Fonts (Quicksand) · Firebase (planned)

## Project layout

```
lib/
├── core/          # theme, router, design system, app state
├── features/      # home, earnings, coach (Leo), goals, progress, shell
└── main.dart
```

Hand-drawn assets live in `assets/images/` (cup, mascot, etc.).
