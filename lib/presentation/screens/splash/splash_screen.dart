import 'package:flutter/material.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';

/// Splash Screen - First screen shown when app launches
/// Design: Figma node-id=232:494
/// Exact Dimensions from Figma:
/// - Screen: 375x812px (iPhone X/11 Pro size)
/// - Logo: 121.125x58.882px
/// - Logo Position: left=127px, top=377px
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Wait for 3 seconds then go to onboarding
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Navigate to second splash
    Navigator.pushReplacementNamed(context, '/splash-two');
  }

  @override
  Widget build(BuildContext context) {
    // Exact dimensions from Figma (375x812 artboard)
    // Match logo size with second splash (120)
    const logoWidth = 120.0;
    const logoHeight = 120.0;
    const logoLeft = 127.5; // center for 120 on 375 width
    const logoTop = 346.0; // center vertically (approx) for 812 height

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Logo positioned exactly as in Figma
          Positioned(
            left: logoLeft.w(context),
            top: logoTop.h(context),
            child: SizedBox(
              width: logoWidth.w(context),
              height: logoHeight.h(context),
              child: Image.asset(
                AppAssets.logo, // Using centralized asset path
                width: logoWidth.w(context),
                height: logoHeight.h(context),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback design matching Figma logo
                  return _buildFallbackLogo(
                    logoWidth.w(context),
                    logoHeight.h(context),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fallback logo that matches the Figma design
  Widget _buildFallbackLogo(double width, double height) {
    // Scale elements relative to the original Figma logo width (121.125)
    final double scale = width / 121.125;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Letter "F"
          Text(
            'F',
            style: TextStyle(
              fontSize: 40.sp(context),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              height: 1.0,
            ),
          ),
          // Orange dome/cloche icon (two circles representing "oo")
          Container(
            width: (32 * scale).toDouble(),
            height: (32 * scale).toDouble(),
            margin: EdgeInsets.symmetric(horizontal: (2 * scale).toDouble()),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: (12 * scale).toDouble(),
                height: (12 * scale).toDouble(),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Container(
            width: (32 * scale).toDouble(),
            height: (32 * scale).toDouble(),
            margin: EdgeInsets.only(right: (2 * scale).toDouble()),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: (12 * scale).toDouble(),
                height: (12 * scale).toDouble(),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Letter "d"
          Text(
            'd',
            style: TextStyle(
              fontSize: 40.sp(context),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
