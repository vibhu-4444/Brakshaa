# Firebase Setup

Firebase dependencies are declared, but runtime initialization is intentionally not wired until real Firebase config files are available.

## Required Firebase Products

- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Cloud Functions
- Firebase Cloud Messaging
- Crashlytics
- Analytics

## Setup Steps

1. Install FlutterFire CLI.
2. Create or select a Firebase project.
3. Run:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

4. This generates `lib/firebase_options.dart` and native config files.
5. Initialize Firebase in `main.dart` before `runApp`.

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

6. Replace local service implementations with Firebase adapters behind the existing interfaces.

## Firestore Collections

Suggested top-level collections:

- `users`
- `farms`
- `diagnoses`
- `communityPosts`
- `marketPrices`
- `financeTransactions`
- `notifications`
- `offlineMutations`

## Security Notes

- Never commit Firebase config secrets beyond standard client config.
- Enforce owner checks for profile, farm, diagnosis, and finance documents.
- Validate uploaded images by MIME type and size in Storage rules.
- Use Cloud Functions for trusted AI calls and paid model credentials.
