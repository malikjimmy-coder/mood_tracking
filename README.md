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
│   ├── main.dart                                  # App entrypoint, ProviderScope + theme
│   ├── constants/
│   │   ├── app_colors.dart                        # Color tokens
│   │   ├── app_dimensions.dart                    # Sizes, paddings, radii
│   │   ├── app_icons.dart                         # SVG icon paths
│   │   ├── app_images.dart                        # PNG image paths
│   │   ├── app_strings.dart                       # User-facing strings
│   │   └── app_text_styles.dart                   # Typography tokens
│   ├── models/
│   │   ├── insight_model.dart                     # Calories / weight / hydration
│   │   ├── mood_model.dart                        # MoodType enum + model
│   │   └── workout_model.dart                     # Workout + WorkoutType
│   ├── controllers/                               # Riverpod StateNotifiers
│   │   ├── calendar_controller.dart
│   │   ├── home_controller.dart                   # Selected date, week math, daytime timer
│   │   ├── mood_controller.dart                   # Wheel angle → mood
│   │   ├── nav_controller.dart                    # Active bottom-nav tab
│   │   └── plan_controller.dart                   # Training plan + drag/drop swap
│   ├── utils/
│   │   └── date_utils.dart                        # Week math, formatting helpers
│   └── views/
│       ├── root_screen.dart                       # IndexedStack shell + bottom nav
│       ├── calendar/
│       │   └── calendar_bottom_sheet.dart
│       ├── home/
│       │   ├── home_screen.dart                   # Dashboard
│       │   └── widgets/
│       │       ├── calories_card_widget.dart      # Gradient progress bar
│       │       ├── hydration_card_widget.dart     # CustomPainter dotted axis
│       │       ├── weight_card_widget.dart
│       │       ├── week_strip_widget.dart
│       │       └── workout_card_widget.dart
│       ├── mood/
│       │   ├── mood_screen.dart                   # Torch-light gradient + wheel
│       │   └── widgets/
│       │       ├── mood_face_widget.dart          # Image-based mood face
│       │       └── mood_wheel_widget.dart         # SweepGradient + drag handle
│       ├── plan/
│       │   ├── plan_screen.dart                   # Training calendar
│       │   └── widgets/
│       │       ├── week_section_widget.dart
│       │       └── workout_day_row_widget.dart    # LongPressDraggable + DragTarget
│       ├── profile/
│       │   └── profile_screen.dart                # Avatar, stats, settings, sign out
│       └── shared/widgets/
│           ├── bottom_nav_bar.dart
│           └── user_avatar_widget.dart
├── assets/
│   ├── icons/                                     # SVG icons (bell, sun, moon, nav, workouts, …)
│   └── images/                                    # PNG mood faces (calm, content, peaceful, happy)
├── screenshots/                                   # Design references
├── test/
│   └── widget_test.dart
├── android/  ios/  macos/  linux/  windows/  web/ # Standard Flutter platform folders
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
├── .fvmrc                                         # Pins Flutter 3.35.4
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
