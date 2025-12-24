import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Onboarding Screen - First onboarding page
/// Design: Figma node-id=154:23
/// Exact Dimensions from Figma:
/// - Screen: 375x812px (iPhone X/11 Pro size)
/// - Image placeholder: 240x292px at (67, 114)
/// - Title: "All your favorites" at (187, 469)
/// - Description: at (187, 516) with width 324px
/// - Slide indicator: 76x10px at (149, 596)
/// - Button: 327x62px at (24, 675)
/// - Skip text: at (187, 753)
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  late List<OnboardingData> _pages;

  // Note: Onboarding pages are initialized in build method to access localization

  @override
  void initState() {
    super.initState();
    // Initialize pages in initState to avoid context issues
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skipOnboarding() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  List<OnboardingData> _getPages(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      OnboardingData(
        title: loc.allYourFavorites,
        description: loc.allYourFavoritesDesc,
        imageColor: AppColors.mutedGray,
        isLastPage: false,
      ),
      OnboardingData(
        title: loc.orderFromChosenChef,
        description: loc.orderFromChosenChefDesc,
        imageColor: AppColors.mutedGray,
        isLastPage: false,
      ),
      OnboardingData(
        title: loc.freeDeliveryOffers,
        description: loc.freeDeliveryOffersDesc,
        imageColor: AppColors.mutedGray,
        isLastPage: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    _pages = _getPages(context);

    // Exact dimensions from Figma (375x812 artboard)
    const imageWidth = 240.0;
    const imageHeight = 292.0;
    const imageLeft = 67.0;
    const imageTop = 114.0;

    const titleTop = 469.0;

    const descWidth = 324.0;
    const descTop = 516.0;

    const indicatorWidth = 76.0;
    const indicatorHeight = 10.0;
    const indicatorLeft = 149.0;
    const indicatorTop = 596.0;

    const buttonWidth = 327.0;
    const buttonHeight = 62.0;
    const buttonLeft = 24.0;
    const buttonTop = 675.0;

    const skipTop = 753.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // PageView for onboarding pages
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Image placeholder
                  Positioned(
                    left: imageLeft.w(context),
                    top: imageTop.h(context),
                    child: CustomNetworkImage(
                      imageUrl: AppData.onboardingImages[index],
                      width: imageWidth.w(context),
                      height: imageHeight.h(context),
                      borderRadius: 12.w(context),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Title
                  Positioned(
                    top: titleTop.h(context),
                    left: 0,
                    right: 0,
                    child: Text(
                      _pages[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 24.w(context),
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),

                  // Description
                  Positioned(
                    top: descTop.h(context),
                    left: (context.screenWidth - descWidth.w(context)) / 2,
                    width: descWidth.w(context),
                    child: Text(
                      _pages[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: AppColors.mutedGrayDarker,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Page indicator
          Positioned(
            left: indicatorLeft.w(context),
            top: indicatorTop.h(context),
            child: SizedBox(
              width: indicatorWidth.w(context),
              height: indicatorHeight.h(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w(context)),
                    width: _currentPage == index
                        ? 20.w(context)
                        : 10.w(context),
                    height: indicatorHeight.h(context),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primary
                          : AppColors.neutralD9,
                      borderRadius: BorderRadius.circular(5.w(context)),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Next/Get Started button
          Positioned(
            left: buttonLeft.w(context),
            top: buttonTop.h(context),
            child: GestureDetector(
              onTap: _nextPage,
              child: Container(
                width: buttonWidth.w(context),
                height: buttonHeight.h(context),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.w(context)),
                ),
                child: Center(
                  child: Text(
                    _currentPage == _pages.length - 1
                        ? loc.getStarted
                        : loc.nextButton,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 14.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Skip button (hidden on last page)
          if (_currentPage < _pages.length - 1)
            Positioned(
              top: skipTop.h(context),
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: _skipOnboarding,
                child: Text(
                  'Skip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.w(context),
                    fontWeight: FontWeight.w400,
                    color: AppColors.mutedGrayDarker,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Onboarding page data model
class OnboardingData {
  final String title;
  final String description;
  final Color imageColor;
  final bool isLastPage;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageColor,
    required this.isLastPage,
  });
}
