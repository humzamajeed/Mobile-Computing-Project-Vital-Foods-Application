import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Withdraw Success Screen (Figma node 601-1781)
class WithdrawSuccessScreen extends StatelessWidget {
  const WithdrawSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative sparkles
          Positioned(
            top: 150.h(context),
            left: 60.w(context),
            child: _buildSparkle(
              context,
              24.w(context),
              AppColors.primary.withValues(alpha: 0.6),
            ),
          ),
          Positioned(
            top: 180.h(context),
            right: 80.w(context),
            child: _buildSparkle(
              context,
              16.w(context),
              AppColors.accentPeach.withValues(alpha: 0.5),
            ),
          ),
          Positioned(
            top: 220.h(context),
            right: 50.w(context),
            child: _buildSparkle(
              context,
              20.w(context),
              AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          Positioned(
            top: 200.h(context),
            left: 40.w(context),
            child: _buildSparkle(
              context,
              12.w(context),
              AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            top: 260.h(context),
            left: 100.w(context),
            child: _buildSparkle(
              context,
              14.w(context),
              AppColors.accentPeach.withValues(alpha: 0.4),
            ),
          ),
          Positioned(
            top: 240.h(context),
            right: 120.w(context),
            child: _buildSparkle(
              context,
              18.w(context),
              AppColors.accentPeach.withValues(alpha: 0.3),
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success icon
                Container(
                  width: 120.w(context),
                  height: 120.w(context),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 60.w(context),
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 40.h(context)),
                Text(
                  'Withdraw Successful',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontSize: 20.sp(context),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // OK button at bottom
          Positioned(
            bottom: 40.h(context),
            left: 20.w(context),
            right: 20.w(context),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h(context)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w(context)),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'OK',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 16.sp(context),
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle(BuildContext context, double size, Color color) {
    return Icon(Icons.star, size: size, color: color);
  }
}
