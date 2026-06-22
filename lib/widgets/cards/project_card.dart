import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../pages/project_details_page.dart';
import '../buttons/primary_button.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? liveDemoUrl;
  final List<String>? innerImages;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.liveDemoUrl,
    this.innerImages,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  /// Resolves image widget from asset path or network URL.
  Widget _buildImage(BoxFit fit, {double? width}) {
    if (widget.imageUrl.startsWith('http')) {
      return Image.network(widget.imageUrl, fit: fit, width: width);
    }
    return Image.asset(widget.imageUrl, fit: fit, width: width);
  }

  /// Navigates to project gallery page.
  void _openProjectDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectGalleryPage(
          title: widget.title,
          description: widget.description,
          technologies: widget.technologies,
          images: widget.innerImages!,
        ),
      ),
    );
  }

  bool get _hasInnerImages =>
      widget.innerImages != null && widget.innerImages!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.35),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: ResponsiveBreakpoints.of(context).isMobile
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
          border: Border.all(
            color: isHovered
                ? AppColors.accent
                : AppColors.gradientElement.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
        transform: isHovered
            ? Matrix4.translationValues(0.0, -8.0, 0.0)
            : Matrix4.identity(),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Image Section ──────────────────────────────────
            _buildImageSection(),

            // ── Info Section ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 52,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 68,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.technologies
                          .map(
                            (tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds image area: full-width, no crop, dynamic height.
  Widget _buildImageSection() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 160, maxHeight: 260),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // ─── Layer 1: Full-width image (no crop, no side gaps) ───
          GestureDetector(
            onTap: () {
              if (_hasInnerImages) {
                _openProjectDetails();
                return;
              }
              final isMobile = ResponsiveBreakpoints.of(context).isMobile;
              if (isMobile && widget.liveDemoUrl != null) {
                _launchUrl(widget.liveDemoUrl);
              }
            },
            child: ClipRect(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: isHovered ? 1.05 : 1.0,
                child: widget.imageUrl.isEmpty
                    ? Container(
                        height: 200,
                        color: AppColors.primary.withValues(alpha: 0.1),
                        child: Center(
                          child: Icon(
                            Icons.domain,
                            size: 64,
                            color: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                      )
                    : _buildImage(BoxFit.fitWidth, width: double.infinity),
              ),
            ),
          ),

          // ─── Layer 2: Floating image count badge (top right) ───
          if (_hasInnerImages)
            Positioned(
              top: 12,
              right: 12,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity:
                    (ResponsiveBreakpoints.of(context).isMobile || isHovered)
                    ? 1.0
                    : 0.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.innerImages!.length} Images',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ─── Layer 3: Subtle bottom gradient ───
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ─── Layer 4: Hover overlay (desktop) ───
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isHovered ? 1.0 : 0.0,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: Center(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      if (_hasInnerImages)
                        PrimaryButton(
                          text: 'View Details',
                          icon: const Icon(Icons.photo_library, size: 16),
                          onPressed: _openProjectDetails,
                        ),

                      if (widget.liveDemoUrl != null)
                        PrimaryButton(
                          text: 'Live Demo',
                          icon: const Icon(Icons.open_in_new, size: 16),
                          onPressed: () => _launchUrl(widget.liveDemoUrl),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ─── Layer 5: Mobile action buttons (always visible) ───
          Positioned(
            bottom: 10,
            right: 12,
            child: Builder(
              builder: (context) {
                final isMobile = ResponsiveBreakpoints.of(context).isMobile;
                if (!isMobile) return const SizedBox.shrink();
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_hasInnerImages)
                      _MobileActionChip(
                        icon: Icons.photo_library,
                        label: 'Gallery',
                        color: AppColors.primary,
                        onTap: _openProjectDetails,
                      ),
                    if (widget.liveDemoUrl != null)
                      _MobileActionChip(
                        icon: Icons.open_in_new,
                        label: 'View',
                        color: AppColors.primary,
                        onTap: () => _launchUrl(widget.liveDemoUrl),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Small action chip for mobile bottom-right overlay.
class _MobileActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MobileActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
