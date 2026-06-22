import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GalleryThumbnailStrip extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final ScrollController scrollController;
  final ValueChanged<int> onTap;

  const GalleryThumbnailStrip({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.scrollController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final isSelected = index == currentIndex;
            return _ThumbnailItem(
              imagePath: images[index],
              isSelected: isSelected,
              onTap: () => onTap(index),
            );
          },
        ),
      ),
    );
  }
}

class _ThumbnailItem extends StatefulWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThumbnailItem({
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ThumbnailItem> createState() => _ThumbnailItemState();
}

class _ThumbnailItemState extends State<_ThumbnailItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double targetOpacity = widget.isSelected
        ? 1.0
        : (_isHovered ? 0.85 : 0.45);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeInOut,
          width: 68,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isSelected
                  ? AppColors.accent
                  : AppColors.primary.withValues(alpha: 0.1),
              width: widget.isSelected ? 2.5 : 1.0,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: targetOpacity,
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  child: Icon(
                    Icons.broken_image_rounded,
                    color: AppColors.primary.withValues(alpha: 0.25),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
