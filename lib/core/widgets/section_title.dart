import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double lineWidth;
  final double? letterSpacing;

  const SectionTitle({
    super.key,
    required this.title,
    this.lineWidth = 60,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFFFAFAF8) : const Color(0xFF1A1814),
              letterSpacing: letterSpacing,
            ),
            textAlign: TextAlign.center,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Container(
          height: 4,
          width: lineWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [Color(0xFFFAFAF8), Color(0xFFA8947C)]
                  : const [Color(0xFF2C2C2A), Color(0xFF8B7355)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate().scaleX(delay: 300.ms, duration: 600.ms),
      ],
    );
  }
}
