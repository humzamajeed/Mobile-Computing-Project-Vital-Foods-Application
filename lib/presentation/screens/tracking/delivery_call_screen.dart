import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Delivery Call Screen - Phone call interface with delivery person
/// Design: Figma node-id=38-201
/// Shows active call screen with mute, end call, and speaker buttons
class DeliveryCallScreen extends StatelessWidget {
  const DeliveryCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(AppAssets.deliveryPerson, fit: BoxFit.cover),
          ),
          // Dark overlay background
          Positioned.fill(
            child: Container(
              color: AppColors.secondary.withValues(alpha: 0.85),
            ),
          ),

          // Bottom white card - call interface
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 377.h(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.w(context)),
                  topRight: Radius.circular(24.w(context)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    blurRadius: 40,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // User profile image
                  Positioned(
                    left: (context.screenWidth / 2) - (105.w(context) / 2),
                    top: 24.h(context),
                    child: Container(
                      width: 105.w(context),
                      height: 105.h(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage(AppAssets.deliveryPerson),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Name
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 142.h(context),
                    child: Center(
                      child: Text(
                        'John Doe',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 20.w(context),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  // Status text
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 173.h(context),
                    child: Center(
                      child: Text(
                        loc.connecting,
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 16.w(context),
                          color: AppColors.mutedGrayDark,
                          height: 1.29,
                        ),
                      ),
                    ),
                  ),

                  // Bottom buttons row
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 222.h(context),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Mute button
                          _buildCallButton(
                            context,
                            48.229,
                            AppColors.border,
                            Icons.mic_off,
                            AppColors.textPrimary,
                            () {
                              // Toggle mute
                            },
                          ),

                          SizedBox(width: 30.w(context)),

                          // End call button (larger, red)
                          _buildCallButton(
                            context,
                            60.385,
                            AppColors.error,
                            Icons.call_end,
                            AppColors.white,
                            () {
                              Navigator.pop(context);
                            },
                            isLarge: true,
                          ),

                          SizedBox(width: 30.w(context)),

                          // Speaker button
                          _buildCallButton(
                            context,
                            48.229,
                            AppColors.border,
                            Icons.volume_up,
                            AppColors.textPrimary,
                            () {
                              // Toggle speaker
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton(
    BuildContext context,
    double size,
    Color bgColor,
    IconData icon,
    Color iconColor,
    VoidCallback onTap, {
    bool isLarge = false,
  }) {
    final buttonSize = size.w(context);
    final iconSize = isLarge ? 30.0.w(context) : 26.0.w(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: isLarge
              ? [
                  BoxShadow(
                    color: bgColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ]
              : null,
        ),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
