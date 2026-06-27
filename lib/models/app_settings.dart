import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.light,
    this.locale = const Locale('en'),
    this.pushAlertsEnabled = true,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final bool pushAlertsEnabled;

  bool get darkMode => themeMode == ThemeMode.dark;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? pushAlertsEnabled,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      pushAlertsEnabled: pushAlertsEnabled ?? this.pushAlertsEnabled,
    );
  }
}
