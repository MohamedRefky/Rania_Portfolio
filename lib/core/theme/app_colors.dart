import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFFFAFAF8);
  static const Color cardBackground = Color(0xFFF0EDE8);

  // Accents
  static const Color primary = Color(0xFF2C2C2A); // Charcoal
  static const Color secondary = Color(0xFF8B7355); // Warm Taupe
  static const Color accent = Color(0xFFC9A96E); // Gold

  // Extra gradient color
  static const Color gradientElement = Color(0xFFE8E2D7); // Soft Warm Sand

  // Text
  static const Color textPrimary = Color(0xFF1A1814);
  static const Color textSecondary = Color(0xFF8B7355);

  // Primary Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
