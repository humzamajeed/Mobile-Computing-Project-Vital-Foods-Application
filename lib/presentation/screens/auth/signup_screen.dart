import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/core/utils/app_routes.dart';

/// Sign Up Screen - New user registration screen
/// Design: Figma node-id=38-1481
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    authProvider.clearError();

    final result = await authProvider.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      name: _nameController.text,
    );

    if (!mounted) return;

    if (result.isSuccess) {
      navigator.pushReplacementNamed(AppRoutes.locationAccess);
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'Sign up failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const whiteBgTop = 233.0;
    const whiteBgHeight = 579.0;
    const titleTop = 119.0;
    const subtitleLeft = 78.5;
    const subtitleTop = 158.0;
    const fieldWidth = 327.0;
    const fieldHeight = 62.0;
    const fieldLeft = 24.0;
    const nameLabelTop = 257.0;
    const nameFieldTop = 281.0;
    const emailLabelTop = 367.0;
    const emailFieldTop = 391.0;
    const passLabelTop = 477.0;
    const passFieldTop = 501.0;
    const retypeLabelTop = 587.0;
    const retypeFieldTop = 611.0;
    const buttonTop = 720.0;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.screenHeight,
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              final loc = AppLocalizations.of(context)!;
              final obscurePassword = authProvider.obscurePassword;
              final obscureConfirmPassword =
                  authProvider.obscureConfirmPassword;
              final isLoading = authProvider.isLoading;

              return Stack(
                children: [
                  // Decorative background rays
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
                    top: whiteBgTop.h(context),
                    child: Container(
                      width: context.screenWidth,
                      height: whiteBgHeight.h(context),
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
                    top: 50.h(context),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
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

                  // Title "Sign Up"
                  Positioned(
                    top: titleTop.h(context),
                    left: 0,
                    right: 0,
                    child: Text(
                      loc.signUp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 30.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  // Subtitle
                  Positioned(
                    left: subtitleLeft.w(context),
                    top: subtitleTop.h(context),
                    child: Text(
                      loc.pleaseSignUp,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.white.withValues(alpha: 0.85),
                        height: 1.625,
                      ),
                    ),
                  ),

                  // NAME Label
                  Positioned(
                    left: fieldLeft.w(context),
                    top: nameLabelTop.h(context),
                    child: Text(
                      loc.name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 13.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // Name Field
                  Positioned(
                    left: fieldLeft.w(context),
                    top: nameFieldTop.h(context),
                    child: Container(
                      width: fieldWidth.w(context),
                      height: fieldHeight.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundGrey,
                        borderRadius: BorderRadius.circular(10.w(context)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.w(context),
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'John doe',
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

                  // EMAIL Label
                  Positioned(
                    left: fieldLeft.w(context),
                    top: emailLabelTop.h(context),
                    child: Text(
                      'EMAIL',
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
                    top: emailFieldTop.h(context),
                    child: Container(
                      width: fieldWidth.w(context),
                      height: fieldHeight.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundGrey,
                        borderRadius: BorderRadius.circular(10.w(context)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
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

                  // PASSWORD Label
                  Positioned(
                    left: fieldLeft.w(context),
                    top: passLabelTop.h(context),
                    child: Text(
                      'PASSWORD',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 13.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // Password Field
                  Positioned(
                    left: fieldLeft.w(context),
                    top: passFieldTop.h(context),
                    child: Container(
                      width: fieldWidth.w(context),
                      height: fieldHeight.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundGrey,
                        borderRadius: BorderRadius.circular(10.w(context)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: obscurePassword,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: '**********',
                                hintStyle: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 14.w(context),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textHint,
                                  letterSpacing: 6.65,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                authProvider.togglePasswordVisibility(),
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textHint,
                              size: 20.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // RE-TYPE PASSWORD Label
                  Positioned(
                    left: fieldLeft.w(context),
                    top: retypeLabelTop.h(context),
                    child: Text(
                      loc.confirmPassword.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 13.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // Re-Type Password Field
                  Positioned(
                    left: fieldLeft.w(context),
                    top: retypeFieldTop.h(context),
                    child: Container(
                      width: fieldWidth.w(context),
                      height: fieldHeight.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundGrey,
                        borderRadius: BorderRadius.circular(10.w(context)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: obscureConfirmPassword,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: '**********',
                                hintStyle: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 14.w(context),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textHint,
                                  letterSpacing: 6.65,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                authProvider.toggleConfirmPasswordVisibility(),
                            child: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textHint,
                              size: 20.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Sign Up Button
                  Positioned(
                    left: fieldLeft.w(context),
                    top: buttonTop.h(context),
                    child: GestureDetector(
                      onTap: isLoading ? null : () => _handleSignUp(context),
                      child: Container(
                        width: fieldWidth.w(context),
                        height: fieldHeight.w(context),
                        decoration: BoxDecoration(
                          color: isLoading
                              ? AppColors.primary.withValues(alpha: 0.6)
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(12.w(context)),
                        ),
                        child: Center(
                          child: isLoading
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
                                  loc.signUp.toUpperCase(),
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
                ],
              );
            },
          ),
        ),
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
