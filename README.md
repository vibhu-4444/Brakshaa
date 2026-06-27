# Brakshaa 3.0

Brakshaa is a Flutter smart-farming application converted from the attached Stitch export. The implementation preserves the provided premium mobile UI language: soft beige background, emerald actions, glass cards, rounded surfaces, bottom navigation, AI diagnosis, community, expense/market, and farmer profile screens.

## Current Build

- Flutter + Dart app scaffold with Riverpod, GoRouter, Clean Architecture-style feature folders, repositories, services, models, widgets, themes, and localization.
- Five Stitch-derived screens implemented: Home, Diagnose, Community, Market/Expense Tracker, Profile.
- Functional local-first flows for guest/email/Google/phone auth mock, diagnosis analysis, camera/gallery pick, community likes/posts, transaction entry, profile settings, language switch, dark mode, and push-alert toggles.
- Firebase-ready dependencies and service boundaries are included, but Firebase is not initialized until platform config files are added.

## Setup

Install Flutter stable or use the portable SDK cloned during this build:

```powershell
C:\Users\GODFATHER\tools\flutter\bin\flutter.bat --version
```

Then run:

```bash
flutter pub get
flutter run
```

If Flutter is not on PATH, use the full local SDK path:

```powershell
& 'C:\Users\GODFATHER\tools\flutter\bin\flutter.bat' pub get
& 'C:\Users\GODFATHER\tools\flutter\bin\flutter.bat' run -d chrome
```

## Project Structure

```text
lib/
  core/              App state, routing, localization, theme
  features/          Independent feature UI and controllers
  generated/         Generated-style constants
  models/            Immutable app models
  repositories/      Repository interfaces and local implementation
  services/          Auth, AI, camera, notifications, offline sync
  utils/             Small utilities
  widgets/           Shared UI components
assets/images/       Bundled Stitch-derived imagery
docs/                Architecture and implementation guides
```

## Verification

Verified with Flutter `3.44.4` and Dart `3.12.2` from `C:\Users\GODFATHER\tools\flutter`.

```bash
flutter pub get
flutter analyze
flutter test
flutter build web
```

The app is also running locally through Flutter web server at:

```text
http://127.0.0.1:53170
```

Environment notes: Chrome/Edge web targets are available. Android SDK is not installed, and the Visual Studio Windows toolchain is incomplete, so Android and Windows native builds require local toolchain setup.
