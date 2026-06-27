import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => LocalNotificationService(),
);

abstract class NotificationService {
  Future<String> registerDevice();
  Future<void> unregisterDevice();
  Future<void> scheduleWeatherAlert();
}

class LocalNotificationService implements NotificationService {
  @override
  Future<String> registerDevice() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return 'local-dev-token';
  }

  @override
  Future<void> unregisterDevice() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }

  @override
  Future<void> scheduleWeatherAlert() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }
}

class NotificationState {
  const NotificationState({
    this.enabled = true,
    this.deviceToken,
    this.lastMessage,
  });

  final bool enabled;
  final String? deviceToken;
  final String? lastMessage;

  NotificationState copyWith({
    bool? enabled,
    String? deviceToken,
    String? lastMessage,
  }) {
    return NotificationState(
      enabled: enabled ?? this.enabled,
      deviceToken: deviceToken,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
