import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrakshaaColors {
  const BrakshaaColors._();

  static const surface = Color(0xFFFAF9F4);
  static const surfaceDim = Color(0xFFDBDAD5);
  static const surfaceContainerLow = Color(0xFFF5F4EF);
  static const surfaceContainer = Color(0xFFEFEEE9);
  static const surfaceContainerHigh = Color(0xFFE9E8E3);
  static const surfaceContainerHighest = Color(0xFFE3E3DE);
  static const onSurface = Color(0xFF1B1C19);
  static const onSurfaceVariant = Color(0xFF3E4941);
  static const outline = Color(0xFF6E7A70);
  static const outlineVariant = Color(0xFFBDCABF);
  static const primary = Color(0xFF006A40);
  static const primaryContainer = Color(0xFF0D8553);
  static const primaryFixed = Color(0xFF90F7BB);
  static const secondary = Color(0xFF5D5F5F);
  static const tertiary = Color(0xFF775600);
  static const gold = Color(0xFFF4B400);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const darkBackground = Color(0xFF0D1410);
}

class BrakshaaSpacing {
  const BrakshaaSpacing._();

  static const xs = 8.0;
  static const sm = 16.0;
  static const md = 24.0;
  static const lg = 32.0;
  static const xl = 48.0;
  static const margin = 20.0;
  static const cardRadius = 24.0;
}

class BrakshaaTheme {
  const BrakshaaTheme._();

  static ThemeData light() {
    return _base(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BrakshaaColors.primary,
        brightness: Brightness.light,
        primary: BrakshaaColors.primary,
        secondary: BrakshaaColors.secondary,
        tertiary: BrakshaaColors.tertiary,
        error: BrakshaaColors.error,
        surface: BrakshaaColors.surface,
      ),
      scaffoldBackgroundColor: BrakshaaColors.surface,
    );
  }

  static ThemeData dark() {
    return _base(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BrakshaaColors.primaryFixed,
        brightness: Brightness.dark,
        primary: BrakshaaColors.primaryFixed,
        secondary: BrakshaaColors.surfaceContainerHigh,
        tertiary: BrakshaaColors.gold,
        error: BrakshaaColors.errorContainer,
        surface: BrakshaaColors.darkBackground,
      ),
      scaffoldBackgroundColor: BrakshaaColors.darkBackground,
    );
  }

  static ThemeData _base({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
  }) {
    final jakarta = GoogleFonts.plusJakartaSansTextTheme();
    final inter = GoogleFonts.interTextTheme();
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: colorScheme,
      textTheme: inter.copyWith(
        displayLarge: jakarta.displayLarge?.copyWith(
          fontSize: 48,
          height: 56 / 48,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        headlineLarge: jakarta.headlineLarge?.copyWith(
          fontSize: 32,
          height: 40 / 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        headlineMedium: jakarta.headlineMedium?.copyWith(
          fontSize: 24,
          height: 32 / 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        titleMedium: jakarta.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        labelLarge: jakarta.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
        bodyLarge: inter.bodyLarge?.copyWith(fontSize: 18, height: 28 / 18),
        bodyMedium: inter.bodyMedium?.copyWith(fontSize: 16, height: 24 / 16),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor:
            isDark ? BrakshaaColors.darkBackground.withValues(alpha: 0.72) : Colors.white.withValues(alpha: 0.72),
        foregroundColor: colorScheme.primary,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Colors.white.withValues(alpha: 0.06) : BrakshaaColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
        ),
      ),
    );
  }
}
