# Architecture

Brakshaa is organized around feature independence with shared core services.

## Layers

- `core`: app state, theme, localization, and routing.
- `features`: presentation and feature-local controllers.
- `models`: immutable data contracts used by repositories and UI.
- `repositories`: app data gateway. The current implementation is local-first dummy data.
- `services`: replaceable adapters for auth, AI, camera, notifications, and offline sync.
- `widgets`: shared design-system components from the Stitch UI.

## State Management

Riverpod owns app state:

- `settingsControllerProvider`: theme, locale, push-alert preference.
- `authControllerProvider`: guest and mock authenticated sessions.
- `diagnosisControllerProvider`: selected image, analysis loading, AI result.
- `communityControllerProvider`: feed interactions.
- `financeControllerProvider`: expense transactions.

## Navigation

GoRouter defines:

- `/auth`
- `/home`
- `/diagnose`
- `/community`
- `/market`
- `/profile`

The tabbed app is wrapped by `AppShell`, which provides the glass bottom navigation and the home scan FAB.

## Offline Strategy

`OfflineSyncService` models an offline queue. Production Firestore writes should enqueue mutations locally first, then flush them when connectivity is restored. The repository layer is the right boundary for replacing local dummy data with Firestore cache-backed data.
