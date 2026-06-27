# Testing Instructions

With Flutter on PATH:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Or with the portable SDK cloned during this build:

```powershell
& 'C:\Users\GODFATHER\tools\flutter\bin\flutter.bat' pub get
& 'C:\Users\GODFATHER\tools\flutter\bin\flutter.bat' analyze
& 'C:\Users\GODFATHER\tools\flutter\bin\flutter.bat' test
& 'C:\Users\GODFATHER\tools\flutter\bin\flutter.bat' run -d chrome
```

Verified in this workspace:

```bash
flutter analyze
flutter test
flutter build web
```

Recommended coverage:

- Widget tests for the five Stitch-derived screens.
- Controller tests for auth, diagnosis, community, finance, settings, and offline sync.
- Golden tests for the glass card system and bottom navigation.
- Integration tests for language switch, dark mode, diagnosis analysis, and sign out.

Manual smoke test:

1. Launch the app.
2. Move through all five bottom nav tabs.
3. Toggle Hindi and Dark Mode in Profile.
4. Capture/upload in Diagnose and run Analyze Image.
5. Like a community post and add a demo post.
6. Add a market transaction.
7. Sign out and continue as guest.
