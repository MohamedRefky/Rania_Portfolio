import 'package:flutter/material.dart';

class GalleryArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const GalleryArrow({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<GalleryArrow> createState() => _GalleryArrowState();
}

class _GalleryArrowState extends State<GalleryArrow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.06),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.75),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
