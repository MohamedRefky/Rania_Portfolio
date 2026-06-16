import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF111317);      // Obsidian Slate / Deep Charcoal
  static const Color cardBackground = Color(0xFF1C1F26);  // Anthracite Concrete Grey

  // Accents
  static const Color primary = Color(0xFFE5A93B);         // Warm Brushed Gold
  static const Color secondary = Color(0xFFA69273);       // Stone Taupe
  static const Color accent = Color(0xFFE2C293);          // Champagne Gold

  // Extra gradient color
  static const Color gradientElement = Color(0xFF332D24);  // Warm Bronze Shadow

  // Text
  static const Color textPrimary = Color(0xFFF8FAFC);     // Off-White / Crisp Slate
  static const Color textSecondary = Color(0xFF94A3B8);   // Slate Base 400

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
