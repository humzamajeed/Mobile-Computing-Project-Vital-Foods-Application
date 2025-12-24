import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Offers Screen - Displays current promotions as a popup modal
/// Design: Figma node-id=601-1659
class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [
          // Dark overlay background
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: AppColors.secondary.withValues(alpha: 0.67),
              ),
            ),
          ),

          // Offer Card
          Center(
            child: Container(
              width: 327.w(context),
              margin: EdgeInsets.symmetric(horizontal: 24.w(context)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.accentYellowLight, // Light yellow
                    AppColors.accentOrangeBright, // Orange
                  ],
                ),
                borderRadius: BorderRadius.circular(35.w(context)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative paper plane elements
                  Positioned(
                    top: 60.h(context),
                    left: 60.w(context),
                    child: Transform.rotate(
                      angle: -0.3,
                      child: Icon(
                        Icons.navigation,
                        size: 32.w(context),
                        color: AppColors.white.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80.h(context),
                    right: 50.w(context),
                    child: Transform.rotate(
                      angle: 0.5,
                      child: Icon(
                        Icons.navigation,
                        size: 24.w(context),
                        color: AppColors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 140.h(context),
                    right: 40.w(context),
                    child: Transform.rotate(
                      angle: 0.8,
                      child: Icon(
                        Icons.navigation,
                        size: 28.w(context),
                        color: AppColors.white.withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100.h(context),
                    left: 50.w(context),
                    child: Transform.rotate(
                      angle: -0.6,
                      child: Icon(
                        Icons.navigation,
                        size: 20.w(context),
                        color: AppColors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),

                  // Main content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w(context),
                      vertical: 36.h(context),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title "Hurry Offers!"
                        Text(
                          loc.hurryOffers,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: AppTextStyles.headlineLarge.copyWith(
                            fontSize: 40.sp(context),
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 32.h(context)),
                        // Coupon Code "#1243CD2"
                        Text(
                          '#1243CD2',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontSize: 32.sp(context),
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 18.h(context)),
                        // Description text
                        Text(
                          loc.useCouponGetDiscount,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontSize: 16.sp(context),
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 36.h(context)),
                        // "GOT IT" Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.white,
                                width: 3,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 18.h(context),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.w(context),
                                ),
                              ),
                              backgroundColor: AppColors.transparent,
                            ),
                            child: Text(
                              loc.gotIt,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontSize: 17.sp(context),
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Close Button (X)
          Positioned(
            right: 24.w(context),
            top: MediaQuery.of(context).size.height / 2 - 220.h(context),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.w(context),
                height: 40.w(context),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.close,
                  size: 22.w(context),
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
