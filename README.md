# Mood Tracking

A production-grade Flutter application for tracking mood, workouts, and daily wellness insights. Built with the MVC pattern using Riverpod for state management. Pixel-matched to the supplied design specs across home dashboard, training calendar, and an interactive mood wheel.

## Dependencies Used & Why

| Package          | Version       | Purpose                                       |
| ---------------- | ------------- | --------------------------------------------- |
| flutter_riverpod | ^2.5.1        | Reactive, compile-safe state management       |
| flutter_svg      | ^2.0.10+1     | SVG icon rendering for crisp vector assets    |
| intl             | ^0.19.0       | Locale-aware date formatting                  |
| google_fonts     | ^6.2.1        | Inter typography matching the design system   |
| cupertino_icons  | ^1.0.8        | iOS-style icon glyphs                         |

## Project Structure

```
mood_tracking/
├── lib/
│   ├── main.dart                       # App entrypoint, ProviderScope + theme
│   ├── constants/                      # All design tokens (colors, type, dimensions, icons, images, strings)
│   ├── models/                         # Data classes (workout, mood, insights)
│   ├── controllers/                    # Riverpod StateNotifiers (home, calendar, plan, mood, nav)
│   ├── utils/                          # Pure helpers (date math, formatting)
│   └── views/
│       ├── root_screen.dart            # IndexedStack shell + bottom nav
│       ├── home/                       # Home dashboard + cards (week strip, workout, calories, weight, hydration)
│       ├── calendar/                   # Calendar bottom sheet
│       ├── plan/                       # Training calendar (weeks, day rows)
│       ├── mood/                       # Mood wheel + face (CustomPainter)
│       ├── profile/                    # Profile placeholder
│       └── shared/widgets/             # Bottom nav bar, user avatar
├── assets/
│   ├── icons/                          # SVG icons
│   └── images/                         # PNG image placeholders
├── screenshots/                        # Design references
├── pubspec.yaml
└── README.md
```

## App Screenshots

[View Screenshots](https://github.com/malikjimmy-coder/mood_tracking/tree/main/tree/main/screenshots)

## App Demo Video

[Watch App Demo Video](https://drive.google.com/file/d/1yIU8BG8pVshTI9Zz6_2P6aGC_nEL4OBq/view?usp=sharing)

## App APK

[Download APK](https://github.com/malikjimmy-coder/mood_tracking/raw/main/release/download/v1_0/app-release.apk)

## Getting Started

### Prerequisites

- [FVM](https://fvm.app/) installed
- Flutter `3.35.4` (Dart `3.9.2`) provisioned via FVM (`.fvmrc` already pins this)

### Install & Run

```bash
fvm flutter pub get
fvm flutter run
```

### Build APK

```bash
fvm flutter build apk --release
```

### Run Tests / Static Analysis

```bash
fvm flutter analyze
fvm flutter test
```

## Architecture Notes

- **MVC layering**: views are pure presentation, controllers (Riverpod `StateNotifier`s) own state and side effects, models are immutable value types.
- **Design tokens only**: every color, text style, dimension, icon path, image path, and string lives in `lib/constants/`. View code references only those tokens.
- **Persistent shell**: `RootScreen` uses `IndexedStack` so screens never rebuild on tab switch, preserving scroll position and animation state.
- **Custom painters**: the mood wheel's gradient ring and the four mood faces (calm / content / peaceful / happy) are rendered via `CustomPainter` — no image assets for the faces.
- **Live time-of-day**: `HomeController` runs a `Timer.periodic(60s)` to flip between sun and moon glyphs based on the device clock.
