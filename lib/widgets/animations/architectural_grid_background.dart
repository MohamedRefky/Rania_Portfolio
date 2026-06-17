import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ArchitecturalGridBackground extends StatefulWidget {
  final Widget child;

  const ArchitecturalGridBackground({super.key, required this.child});

  @override
  State<ArchitecturalGridBackground> createState() =>
      _ArchitecturalGridBackgroundState();
}

class _ArchitecturalGridBackgroundState
    extends State<ArchitecturalGridBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // A very slow, subtle animation for grid drifting
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Grid Painting Layer
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _GridPainter(
                  animationValue: _controller.value,
                ),
              );
            },
          ),
        ),
        // Content Layer
        widget.child,
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  final double animationValue;

  _GridPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.035)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.07)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final crossPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.15)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    const double gridSpacing = 60.0;
    // Animate the grid offset slowly
    final double driftX = animationValue * gridSpacing;
    final double driftY = animationValue * gridSpacing * 0.5;

    // Draw main grid lines
    double startX = driftX % gridSpacing;
    for (double x = startX; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    double startY = driftY % gridSpacing;
    for (double y = startY; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw crosshairs at intersections and small coordinates
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Grid coordinates counter
    int colIndex = 0;
    for (double x = startX; x < size.width; x += gridSpacing) {
      int rowIndex = 0;
      for (double y = startY; y < size.height; y += gridSpacing) {
        // Draw small crosshair (+)
        const double crossSize = 4.0;
        canvas.drawLine(
          Offset(x - crossSize, y),
          Offset(x + crossSize, y),
          crossPaint,
        );
        canvas.drawLine(
          Offset(x, y - crossSize),
          Offset(x, y + crossSize),
          crossPaint,
        );

        // Periodically draw a technical coordinate label (e.g., A-1, B-3)
        if (colIndex % 3 == 1 && rowIndex % 4 == 2) {
          final String label = '${_getColLetter(colIndex)}$rowIndex';
          textPainter.text = TextSpan(
            text: label,
            style: TextStyle(
              color: AppColors.secondary.withValues(alpha: 0.15),
              fontSize: 8.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(x + 5, y + 2),
          );
        }
        rowIndex++;
      }
      colIndex++;
    }

    // Draw a prominent "Blueprint Margin Rule" on the left and top
    // Left axis line
    canvas.drawLine(const Offset(40, 0), Offset(40, size.height), axisPaint);
    // Top axis line
    canvas.drawLine(const Offset(0, 40), Offset(size.width, 40), axisPaint);

    // Draw tick marks along the left margin
    for (double y = startY; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(35, y), Offset(45, y), axisPaint);
    }
    // Draw tick marks along the top margin
    for (double x = startX; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 35), Offset(x, 45), axisPaint);
    }
  }

  String _getColLetter(int index) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return letters[index % letters.length];
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
