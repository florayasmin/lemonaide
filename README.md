# 🍋 lemonaide

[started during [cseed](https://www.cseed.co/buildher-team) BuildHER Launchpad Cohort 0] \
\
💵 gamified financial literacy assistant for kids (ages 5–12) and parents. \
🐷 kids track earnings, set savings goals, learn through an AI coach, unlock progress rewards, etc.

## Stack

| Layer | Tech |
|-------|------|
| UI | Flutter, Google Fonts, Flutter Animate |
| State | Riverpod |
| Navigation | GoRouter |
| Backend | Firebase Auth, Cloud Firestore, Analytics |

## Project structure

```
lib/
├── main.dart                 # Entry point
├── app.dart                  # MaterialApp + theme
├── bootstrap.dart            # Firebase & service init
├── core/
│   ├── constants/            # Colors, strings
│   ├── theme/                # Light/dark themes
│   ├── router/               # GoRouter config
│   ├── spacing/              # Responsive spacing scale
│   └── widgets/              # AppButton, AppCard, BounceTap, …
└── features/                 # Feature-first clean architecture
    ├── shell/                # Left nav rail shell
    ├── home/
    ├── earnings/             # domain/, data/, presentation/
    ├── coach/
    ├── goals/
    └── progress/
```

## Getting started

### 1. Install Flutter

[Install Flutter](https://docs.flutter.dev/get-started/install) (SDK ≥ 3.5), then verify:

```bash
flutter doctor
```

### 2. Generate platform folders (first time only)

If `android/` and `ios/` are missing:

```bash
cd lemonaide
flutter create . --project-name lemonaide --org com.lemonaide
```

### 3. Install dependencies & run

```bash
flutter pub get
flutter run
```

### 4. Firebase (when ready)

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Uncomment Firebase init in `lib/bootstrap.dart` and add `firebase_options.dart` (gitignored until you configure).

## Design system

**Palette:** cream `#FFFDF7`, lemon `#FFE66D`, pastel yellow `#FFF4A6`, blue `#7CC7F7`, sky `#BEE3FF`, mint `#E6F7C9`, slate `#4A5A6A`

**Buttons:** fully rounded, chunky padding, soft shadow, bounce-on-tap (`AppButton`)

**Navigation:** 5-item `NavigationRail` on the **left** (Home, Earnings, Coach, Goals, Progress)

## MVP roadmap

- [x] App scaffold, theme, navigation, placeholders
- [ ] Earnings CRUD + Firestore
- [ ] AI coach (OpenAI, child-safe prompts)
- [ ] Savings goals + cup visualization
- [ ] Progress, streaks, badges
