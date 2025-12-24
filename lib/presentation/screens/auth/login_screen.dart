import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/storage/shared_preferences_service.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/presentation/providers/cart_provider.dart';
import 'package:finalproject/presentation/providers/favorite_provider.dart';
import 'package:finalproject/presentation/providers/order_provider.dart';
import 'package:finalproject/core/utils/app_routes.dart';

/// Login Screen - User authentication screen
/// Design: Figma node-id=38:1726
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (!mounted) return;

    // Get all providers and navigators before async operations to avoid BuildContext issues
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    authProvider.clearError();

    final result = await authProvider.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    // Debug: Print result status
    debugPrint('🔍 Login Result - isSuccess: ${result.isSuccess}');
    debugPrint('🔍 Login Result - user: ${result.user}');
    debugPrint('🔍 Login Result - errorMessage: ${result.errorMessage}');

    if (result.isSuccess) {
      // Use result.user directly - it already has the role from Firestore
      final user = result.user;

      // Debug: Print user info
      debugPrint('🔍 Login successful - User ID: ${user?.id}');
      debugPrint('🔍 Login successful - User Email: ${user?.email}');
      debugPrint('🔍 Login successful - User Role: ${user?.role}');
      debugPrint(
        '🔍 User role comparison - user.role == "chef": ${user?.role == 'chef'}',
      );

      if (user != null) {
        // Load user data (cart, favorites, orders) after successful login
        // Providers already obtained before async gap
        // Load cart, favorites, and orders in parallel (fire and forget)
        Future.wait([
          cartProvider.loadCart(user.id),
          favoriteProvider.loadFavorites(user.id),
          orderProvider.loadUserOrders(user.id),
        ]).catchError((e) {
          debugPrint('Error loading user data: $e');
          return <void>[];
        });

        // Check if location access has been shown
        final hasShownLocationAccess =
            SharedPreferencesService.getLocationAccessShown();

        // Check role and route accordingly
        debugPrint('🔍 Checking role - Current role: "${user.role}"');
        if (user.role == 'chef') {
          debugPrint('✅✅✅ CHEF DETECTED - Routing to Seller Dashboard');
          debugPrint('🔍 Route: ${AppRoutes.sellerDashboard}');
          navigator.pushReplacementNamed(AppRoutes.sellerDashboard);
        } else {
          // Show location access page only on first login
          if (!hasShownLocationAccess) {
            debugPrint('📍 First login - Routing to Location Access');
            navigator.pushReplacementNamed(AppRoutes.locationAccess);
          } else {
            debugPrint('❌❌❌ NOT CHEF - Routing to Home (role: "${user.role}")');
            navigator.pushReplacementNamed(AppRoutes.home);
          }
        }
      } else {
        debugPrint('❌❌❌ User is null after login - routing to home');
        navigator.pushReplacementNamed(AppRoutes.home);
      }
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'Login failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    const whiteBgTop = 233.0;
    const whiteBgHeight = 579.0;
    const titleLeft = 138.0;
    const titleTop = 118.0;
    const subtitleLeft = 42.0;
    const subtitleTop = 157.0;
    const fieldWidth = 327.0;
    const fieldHeight = 62.0;
    const fieldLeft = 24.0;
    const emailTop = 281.0;
    const emailLabelTop = 257.0;
    const passTop = 391.0;
    const passLabelTop = 367.0;
    const rememberTop = 477.0;
    const forgotTop = 478.0;
    const forgotLeft = 239.0;
    const buttonTop = 526.0;
    const signupTop = 630.0;
    const orTop = 686.5;
    const socialTop = 711.0;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final obscurePassword = authProvider.obscurePassword;
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

              // Title "Log In"
              Positioned(
                left: titleLeft.w(context),
                top: titleTop.h(context),
                child: Text(
                  loc.logIn,
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
                  loc.pleaseSignIn,
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
                top: emailLabelTop.h(context),
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
                top: emailTop.h(context),
                child: Container(
                  width: fieldWidth.w(context),
                  height: fieldHeight.h(context),
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

              // PASSWORD Label
              Positioned(
                left: fieldLeft.w(context),
                top: passLabelTop.h(context),
                child: Text(
                  loc.password.toUpperCase(),
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
                top: passTop.h(context),
                child: Container(
                  width: fieldWidth.w(context),
                  height: fieldHeight.h(context),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(10.w(context)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 19.w(context)),
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
                              color: AppColors.textHint,
                              letterSpacing: 6.72,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => authProvider.togglePasswordVisibility(),
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

              // Remember me checkbox
              Positioned(
                left: fieldLeft.w(context),
                top: rememberTop.h(context),
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () => authProvider.toggleRememberMe(),
                          child: Container(
                            width: 20.w(context),
                            height: 20.h(context),
                            decoration: BoxDecoration(
                              color: authProvider.rememberMe
                                  ? AppColors.primary
                                  : AppColors.transparent,
                              border: Border.all(
                                color: authProvider.rememberMe
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(4.w(context)),
                            ),
                            child: authProvider.rememberMe
                                ? Icon(
                                    Icons.check,
                                    size: 14.w(context),
                                    color: AppColors.white,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: 10.w(context)),
                        Text(
                          loc.rememberMe,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 13.w(context),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Forgot Password
              Positioned(
                left: forgotLeft.w(context),
                top: forgotTop.h(context),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: Text(
                    loc.forgotPassword,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 14.w(context),
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              // Login Button
              Positioned(
                left: fieldLeft.w(context),
                top: buttonTop.h(context),
                child: GestureDetector(
                  onTap: isLoading ? null : () => _handleLogin(context),
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
                              loc.logIn.toUpperCase(),
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

              // Don't have an account? Sign Up
              Positioned(
                top: signupTop.h(context),
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc.dontHaveAccount,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            color: AppColors.mutedGrayDark,
                          ),
                        ),
                        SizedBox(width: 8.w(context)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.signup);
                          },
                          child: Text(
                            loc.signUp.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 14.w(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Or divider
              Positioned(
                top: orTop.h(context),
                left: 0,
                right: 0,
                child: Text(
                  loc.or,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.w(context),
                    color: AppColors.mutedGrayDark,
                  ),
                ),
              ),

              // Social login icons
              Positioned(
                top: socialTop.h(context),
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIconSvg(
                      context: context,
                      color: AppColors.socialFacebook,
                      svgPath: AppAssets.facebookF,
                    ),
                    SizedBox(width: 30.w(context)),
                    _buildSocialIconSvg(
                      context: context,
                      color: AppColors.socialTwitter,
                      svgPath: AppAssets.twitterBird,
                    ),
                    SizedBox(width: 30.w(context)),
                    _buildSocialIcon(
                      context: context,
                      color: AppColors.secondary,
                      icon: Icons.apple,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSocialIcon({
    required BuildContext context,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 62.w(context),
      height: 62.w(context),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Icon(icon, color: AppColors.white, size: 30.w(context)),
      ),
    );
  }

  Widget _buildSocialIconSvg({
    required BuildContext context,
    required Color color,
    required String svgPath,
  }) {
    return Container(
      width: 62.w(context),
      height: 62.w(context),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: 24.w(context),
          height: 24.w(context),
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

/// Decorative rays painter for login background
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
