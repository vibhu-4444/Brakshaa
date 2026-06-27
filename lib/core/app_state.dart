import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_settings.dart';
import '../models/user_session.dart';
import '../services/auth/auth_service.dart';
import '../services/notifications/notification_service.dart';
import '../services/offline/offline_sync_service.dart';

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AppSettings>(
  (ref) => SettingsController(),
);

final authControllerProvider =
    StateNotifierProvider<AuthController, UserSession>(
  (ref) => AuthController(ref.watch(authServiceProvider)),
);

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, NotificationState>(
  (ref) => NotificationController(ref.watch(notificationServiceProvider)),
);

final offlineSyncControllerProvider =
    StateNotifierProvider<OfflineSyncController, OfflineSyncState>(
  (ref) => OfflineSyncController(ref.watch(offlineSyncServiceProvider)),
);

class SettingsController extends StateNotifier<AppSettings> {
  SettingsController() : super(const AppSettings());

  void toggleTheme(bool darkMode) {
    state = state.copyWith(
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void changeLocale(Locale locale) {
    state = state.copyWith(locale: locale);
  }

  void togglePushAlerts(bool enabled) {
    state = state.copyWith(pushAlertsEnabled: enabled);
  }
}

class AuthController extends StateNotifier<UserSession> {
  AuthController(this._authService) : super(UserSession.guest());

  final AuthService _authService;

  Future<void> continueAsGuest() async {
    state = await _authService.signInAsGuest();
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = await _authService.signInWithEmail(email, password);
  }

  Future<void> signInWithGoogle() async {
    state = await _authService.signInWithGoogle();
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    state = await _authService.signInWithPhone(phoneNumber);
  }

  Future<void> signOut() async {
    state = await _authService.signOut();
  }
}

class NotificationController extends StateNotifier<NotificationState> {
  NotificationController(this._service) : super(const NotificationState());

  final NotificationService _service;

  Future<void> enablePushAlerts() async {
    final token = await _service.registerDevice();
    state = state.copyWith(enabled: true, deviceToken: token);
  }

  Future<void> disablePushAlerts() async {
    await _service.unregisterDevice();
    state = state.copyWith(enabled: false, deviceToken: null);
  }

  Future<void> previewWeatherAlert() async {
    await _service.scheduleWeatherAlert();
    state = state.copyWith(lastMessage: 'Weather alert scheduled');
  }
}

class OfflineSyncController extends StateNotifier<OfflineSyncState> {
  OfflineSyncController(this._service) : super(const OfflineSyncState());

  final OfflineSyncService _service;

  void queue(String description) {
    state = state.copyWith(
      pendingItems: [...state.pendingItems, _service.createTask(description)],
    );
  }

  Future<void> syncNow() async {
    state = state.copyWith(isSyncing: true);
    await _service.flush(state.pendingItems);
    state = state.copyWith(isSyncing: false, pendingItems: const []);
  }
}
