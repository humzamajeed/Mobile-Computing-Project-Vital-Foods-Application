import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';

/// Verification Screen - OTP/Code verification screen
/// Design: Figma node-id=38-1521
/// Exact Dimensions from Figma:
/// - Screen: 375x812px (iPhone X/11 Pro size)
/// - Dark background: #121223
/// - White section: starts at top=233px, height=579px
/// - Back button: 45x45px at (24, 50)
/// - Title "Verification": at (187.5, 119), 30px, Sen Bold, centered
/// - Code boxes: 62x62px, 4 boxes with 26px gap
/// - First box at (24, 282)
/// - Verify button: at (24, 374), 327x62px
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize timer in provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.startResendTimer();
      _startTimer(authProvider);
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer(AuthProvider authProvider) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (authProvider.resendTimer > 0) {
        authProvider.decrementResendTimer();
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _onCodeChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    if (index == 3 && value.isNotEmpty) {
      // Auto-verify when all 4 digits are entered
      _verifyCode();
    }
  }

  void _verifyCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      // Navigate to sign up screen after successful verification
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  void _resendCode() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.resendTimer == 0) {
      authProvider.startResendTimer();
      _startTimer(authProvider);
      // Implement resend code logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Exact dimensions from Figma
    const whiteBgTop = 233.0;
    const whiteBgHeight = 579.0;

    const titleTop = 119.0;
    const subtitleTop = 159.0;
    const subtitleLeft = 45.0;
    const emailTop = 184.0;
    const emailLeft = 108.0;

    const codeLabelTop = 257.5;
    const codeLabelLeft = 24.0;
    const resendTop = 257.0;
    const resendLeft = 243.0;

    const codeBoxSize = 62.0;
    const codeBoxTop = 282.0;
    const codeBoxGap = 26.0;
    const firstBoxLeft = 24.0;

    const buttonTop = 374.0;

    // Scale to current device
    // 45.w(context) removed - use 45.w(context) directly
    // 24.w(context) removed - use 24.w(context) directly
    // 50.w(context) removed - use 50.h(context) directly

    // whiteBgTop.w(context) removed - use whiteBgTop.h(context) directly
    // whiteBgHeight.w(context) removed - use whiteBgHeight.h(context) directly

    // titleTop.w(context) removed - use titleTop.h(context) directly
    // subtitleTop.w(context) removed - use subtitleTop.h(context) directly
    // subtitleLeft.w(context) removed - use subtitleLeft.w(context) directly
    // emailTop.w(context) removed - use emailTop.h(context) directly
    // emailLeft.w(context) removed - use emailLeft.w(context) directly

    // codeLabelTop.w(context) removed - use codeLabelTop.h(context) directly
    // codeLabelLeft.w(context) removed - use codeLabelLeft.w(context) directly
    // resendTop.w(context) removed - use resendTop.h(context) directly
    // resendLeft.w(context) removed - use resendLeft.w(context) directly

    // codeBoxSize.w(context) removed - use codeBoxSize.w(context) directly
    // codeBoxTop.w(context) removed - use codeBoxTop.h(context) directly
    // codeBoxGap.w(context) removed - use codeBoxGap.w(context) directly
    // firstBoxLeft.w(context) removed - use firstBoxLeft.w(context) directly

    // 327.w(context) removed - use 327.w(context) directly
    // 62.w(context) removed - use 62.h(context) directly
    // 24.w(context) removed - use 24.w(context) directly
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

          // Title "Verification"
          Positioned(
            top: titleTop.h(context),
            left: 0,
            right: 0,
            child: Text(
              loc.verification,
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
            width: 285.w(context),
            child: Text(
              loc.enterVerificationCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 16.w(context),
                fontWeight: FontWeight.w400,
                color: AppColors.white.withValues(alpha: 0.9),
                height: 1.625,
              ),
            ),
          ),

          // Email
          Positioned(
            left: emailLeft.w(context),
            top: emailTop.h(context),
            child: Text(
              'example@gmail.com',
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 16.w(context),
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                height: 1.476,
              ),
            ),
          ),

          // CODE Label
          Positioned(
            left: codeLabelLeft.w(context),
            top: codeLabelTop.h(context),
            child: Text(
              loc.verification.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 13.w(context),
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Resend text
          Positioned(
            left: resendLeft.w(context),
            top: resendTop.h(context),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return GestureDetector(
                  onTap: _resendCode,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 14.w(context),
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: loc.resendCode,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: authProvider.resendTimer == 0
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: ' in ${authProvider.resendTimer}sec',
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Code input boxes
          ...List.generate(4, (index) {
            return Positioned(
              left:
                  firstBoxLeft.w(context) +
                  (index * (codeBoxSize.w(context) + codeBoxGap.w(context))),
              top: codeBoxTop.h(context),
              child: Container(
                width: codeBoxSize.w(context),
                height: codeBoxSize.w(context),
                decoration: BoxDecoration(
                  color: AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(10.w(context)),
                ),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.w(context),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _onCodeChanged(index, value),
                  onTap: () {
                    // Clear field when tapped
                    _controllers[index].clear();
                  },
                ),
              ),
            );
          }),

          // Verify Button
          Positioned(
            left: 24.w(context),
            top: buttonTop.h(context),
            child: GestureDetector(
              onTap: _verifyCode,
              child: Container(
                width: 327.w(context),
                height: 62.h(context),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.w(context)),
                ),
                child: Center(
                  child: Text(
                    loc.verify.toUpperCase(),
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
