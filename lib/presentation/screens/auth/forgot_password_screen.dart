import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';

/// Forgot Password Screen - Password recovery screen
/// Design: Figma node-id=38:1607
/// Exact Dimensions from Figma:
/// - Screen: 375x812px (iPhone X/11 Pro size)
/// - Dark background: #121223
/// - White section: starts at top=233px, height=579px
/// - Back button: 45x45px at (24, 50)
/// - Title "Forgot Password": at (187.5, 118), 30px, Sen Bold, centered
/// - Subtitle: at (42, 158), 16px
/// - Email field: at (24, 281), 327x62px
/// - Send Code button: at (24, 373), 327x62px
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Get actual screen size

    // Exact dimensions from Figma
    const whiteBgTop = 233.0;
    const whiteBgHeight = 579.0;

    const titleTop = 118.0;
    const subtitleLeft = 42.0;
    const subtitleTop = 158.0;

    const fieldWidth = 327.0;
    const fieldHeight = 62.0;
    const fieldLeft = 24.0;

    const emailTop = 281.0;
    const emailLabelTop = 257.0;

    // Button top not used directly

    // Scale to current device
    // 45.w(context) removed - use 45.w(context) directly
    // 24.w(context) removed - use 24.w(context) directly
    // 50.w(context) removed - use 50.h(context) directly

    // whiteBgTop.w(context) removed - use whiteBgTop.h(context) directly
    // whiteBgHeight.w(context) removed - use whiteBgHeight.h(context) directly

    // titleTop.w(context) removed - use titleTop.h(context) directly

    // subtitleLeft.w(context) removed - use subtitleLeft.w(context) directly
    // subtitleTop.w(context) removed - use subtitleTop.h(context) directly

    // fieldWidth.w(context) removed - use fieldWidth.w(context) directly
    // fieldHeight.w(context) removed - use fieldHeight.h(context) directly
    // fieldLeft.w(context) removed - use fieldLeft.w(context) directly

    // emailTop.w(context) removed - use emailTop.h(context) directly
    // emailLabelTop.w(context) removed - use emailLabelTop.h(context) directly

    // 373.w(context) removed - use 373.h(context) directly

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // Decorative background rays (top-left)
          Positioned(
            left: -83.w(context),
            top: -94.h(context),
            child: CustomPaint(
              size: Size(250.w(context), 250.h(context)),
              painter: DecorativeRaysPainter(),
            ),
          ),

          // White bottom section
          Positioned(
            left: 0,
            top: whiteBgTop.w(context),
            child: Container(
              width: context.screenWidth,
              height: whiteBgHeight.w(context),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.w(context)),
                  topRight: Radius.circular(24.w(context)),
                ),
              ),
            ),
          ),

          // Back button
          Positioned(
            left: 24.w(context),
            top: 50.w(context),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45.w(context),
                height: 45.w(context),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary,
                  size: 20.w(context),
                ),
              ),
            ),
          ),

          // Title "Forgot Password"
          Positioned(
            top: titleTop.w(context),
            left: 0,
            right: 0,
            child: Text(
              loc.forgotPassword,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 30.w(context),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          // Subtitle
          Positioned(
            left: subtitleLeft.w(context),
            top: subtitleTop.w(context),
            child: Text(
              loc.pleaseEnterEmail,
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 16.w(context),
                fontWeight: FontWeight.w400,
                color: AppColors.white.withValues(alpha: 0.85),
                height: 1.625,
              ),
            ),
          ),

          // EMAIL Label
          Positioned(
            left: fieldLeft.w(context),
            top: emailLabelTop.w(context),
            child: Text(
              loc.email.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 13.w(context),
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Email Field
          Positioned(
            left: fieldLeft.w(context),
            top: emailTop.w(context),
            child: Container(
              width: fieldWidth.w(context),
              height: fieldHeight.w(context),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(10.w(context)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 19.w(context)),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 14.w(context),
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 14.w(context),
                    color: AppColors.textHint,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Send Code Button
          Positioned(
            left: fieldLeft.w(context),
            top: 373.w(context),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return GestureDetector(
                  onTap: authProvider.isLoading
                      ? null
                      : () async {
                          final email = _emailController.text.trim();
                          if (email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loc.pleaseEnterEmail),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            return;
                          }

                          authProvider.clearError();
                          await authProvider.forgotPassword(email);

                          if (!context.mounted) return;

                          if (authProvider.errorMessage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loc.passwordResetEmailSent),
                                backgroundColor: AppColors.successDark,
                              ),
                            );
                            Navigator.pushNamed(context, '/verification');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  authProvider.errorMessage ??
                                      'Failed to send reset email',
                                ),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        },
                  child: Container(
                    width: fieldWidth.w(context),
                    height: fieldHeight.w(context),
                    decoration: BoxDecoration(
                      color: authProvider.isLoading
                          ? AppColors.primary.withValues(alpha: 0.6)
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(12.w(context)),
                    ),
                    child: Center(
                      child: authProvider.isLoading
                          ? SizedBox(
                              width: 20.w(context),
                              height: 20.w(context),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                              ),
                            )
                          : Text(
                              loc.send.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Decorative rays painter for background
class DecorativeRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const numRays = 15;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < numRays; i++) {
      paint.color = AppColors.secondaryLight.withValues(
        alpha: i % 2 == 0 ? 0.3 : 0.5,
      );

      final path = Path();
      path.moveTo(0, 0);

      final angle = (i * 6) * (3.14159 / 180);
      final nextAngle = ((i + 1) * 6) * (3.14159 / 180);

      path.lineTo(
        size.width * 1.5 * (angle / 1.57),
        size.height * 1.5 * (angle / 1.57),
      );
      path.lineTo(
        size.width * 1.5 * (nextAngle / 1.57),
        size.height * 1.5 * (nextAngle / 1.57),
      );

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
