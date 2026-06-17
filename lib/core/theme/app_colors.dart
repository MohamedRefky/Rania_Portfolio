import 'package:flutter/material.dart';

class AppColors {
  static final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static bool get isDark => themeModeNotifier.value == ThemeMode.dark;

  static void toggleTheme() {
    themeModeNotifier.value =
        isDark ? ThemeMode.light : ThemeMode.dark;
  }

  // Backgrounds
  static Color get background =>
      isDark ? const Color(0xFF121212) : const Color(0xFFFAFAF8);
  static Color get cardBackground =>
      isDark ? const Color(0xFF1E1E1C) : const Color(0xFFF0EDE8);

  // Accents
  static Color get primary =>
      isDark ? const Color(0xFFFAFAF8) : const Color(0xFF2C2C2A); // Charcoal
  static Color get secondary =>
      isDark ? const Color(0xFFA8947C) : const Color(0xFF8B7355); // Warm Taupe
  static Color get accent =>
      isDark ? const Color(0xFFD4AF37) : const Color(0xFFC9A96E); // Gold

  // Extra gradient color
  static Color get gradientElement =>
      isDark ? const Color(0xFF2C2C2A) : const Color(0xFFE8E2D7); // Soft Warm Sand

  // Text
  static Color get textPrimary =>
      isDark ? const Color(0xFFFAFAF8) : const Color(0xFF1A1814);
  static Color get textSecondary =>
      isDark ? const Color(0xFFA8947C) : const Color(0xFF8B7355);

  // Primary Gradient
  static LinearGradient get primaryGradient => LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get secondaryGradient => LinearGradient(
        colors: [secondary, accent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
