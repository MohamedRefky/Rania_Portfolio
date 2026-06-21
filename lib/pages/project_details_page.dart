import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/theme/app_colors.dart';

class ProjectDetailsPage extends StatefulWidget {
  final String title;
  final String description;
  final List<String> innerImages;

  const ProjectDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.innerImages,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload resized images into memory before they are displayed
    for (String imagePath in widget.innerImages) {
      precacheImage(ResizeImage(AssetImage(imagePath), width: 1080), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.primary),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : screenSize.width * 0.15,
                vertical: isMobile ? 16 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ).animate().fadeIn(delay: 200.ms).scaleX(),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),

            // Gallery Section
            if (widget.innerImages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: isMobile ? screenSize.height * 0.40 : screenSize.height * 0.55,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: widget.innerImages.length > 1,
                            autoPlay: widget.innerImages.length > 1,
                            autoPlayInterval: const Duration(seconds: 4),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            viewportFraction: isMobile ? 0.85 : 0.65,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: widget.innerImages.map((imagePath) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 15,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: AppColors.primary.withValues(alpha: 0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: InteractiveViewer(
                                        maxScale: 3.0,
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.contain,
                                          cacheWidth: 1080, // Optimizes memory & decode time for large images
                                          gaplessPlayback: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        // Left Arrow
                        if (widget.innerImages.length > 1)
                          Positioned(
                            left: isMobile ? 8 : 32,
                            child: GestureDetector(
                              onTap: () => _carouselController.previousPage(),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        // Right Arrow
                        if (widget.innerImages.length > 1)
                          Positioned(
                            right: isMobile ? 8 : 32,
                            child: GestureDetector(
                              onTap: () => _carouselController.nextPage(),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 12),
                    
                    // Dot Indicators
                    if (widget.innerImages.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.innerImages.asMap().entries.map((entry) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentIndex == entry.key ? 24.0 : 8.0,
                            height: 6.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: _currentIndex == entry.key
                                  ? AppColors.primary
                                  : AppColors.primary.withValues(alpha: 0.2),
                            ),
                          );
                        }).toList(),
                      ).animate().fadeIn(delay: 600.ms),
                  ],
                ),
              ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
