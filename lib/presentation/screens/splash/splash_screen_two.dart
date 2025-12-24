import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/di/injection_container.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/presentation/providers/cart_provider.dart';
import 'package:finalproject/presentation/providers/favorite_provider.dart';
import 'package:finalproject/presentation/providers/order_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/app_routes.dart';

/// Second Splash Screen - transitional splash before onboarding
/// Design target: Figma node-id=601:1224 (375x812)
class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({super.key});

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Check login state using secure storage and shared preferences (like teacher's example)
    final secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'auth_token');
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (token != null && isLoggedIn) {
      // User is logged in - fetch fresh user data from Firebase
      try {
        final container = InjectionContainer();
        final authRepository = container.authRepository;
        final currentUser = await authRepository.getCurrentUser();

        if (!mounted) return;

        if (currentUser != null) {
          final authProvider = Provider.of<AuthProvider>(
            context,
            listen: false,
          );
          authProvider.setUser(currentUser);

          // Load user data (cart, favorites, orders) when app initializes
          final cartProvider = Provider.of<CartProvider>(
            context,
            listen: false,
          );
          final favoriteProvider = Provider.of<FavoriteProvider>(
            context,
            listen: false,
          );
          final orderProvider = Provider.of<OrderProvider>(
            context,
            listen: false,
          );

          // Load cart, favorites, and orders in parallel (fire and forget)
          Future.wait([
            cartProvider.loadCart(currentUser.id),
            favoriteProvider.loadFavorites(currentUser.id),
            orderProvider.loadUserOrders(currentUser.id),
          ]).catchError((e) {
            debugPrint('Error loading user data: $e');
            return <void>[];
          });

          // Check role and route accordingly
          if (currentUser.role == 'chef') {
            Navigator.pushReplacementNamed(context, AppRoutes.sellerDashboard);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        } else {
          // Token exists but user fetch failed - go to login
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      } catch (e) {
        // Error fetching user - go to login
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } else {
      if (!mounted) return;
      // Navigate to onboarding if not logged in
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Figma 375x812 base
    // Match Figma proportions: logo a bit smaller and centered
    const heroSize = 120.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Top-left radial ray (grey) - positioned to start from exact corner
          Positioned(
            left: -140.w(context),
            top: -140.h(context),
            child: const _RayBurst(
              diameter: 280,
              color: AppColors.border,
              rays: 20,
              sweepDegrees: 90,
              startDegrees: 0,
            ),
          ),

          // Bottom-right radial ray (orange) - positioned to start from exact corner
          Positioned(
            right: -200.w(context),
            bottom: -200.h(context),
            child: const _RayBurst(
              diameter: 400,
              color: AppColors.primary,
              rays: 20,
              sweepDegrees: 90,
              startDegrees: 180,
            ),
          ),

          // Center hero/logo
          // Center logo
          Center(
            child: SizedBox(
              width: heroSize.w(context),
              height: heroSize.w(context),
              child: Image.asset(
                AppAssets.logo,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _fallbackMark(context, heroSize),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallbackMark(BuildContext context, double baseSize) {
    final double scale = baseSize / 121.125;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'F',
            style: TextStyle(
              fontSize: 40.sp(context),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            width: (32 * scale).toDouble(),
            height: (32 * scale).toDouble(),
            margin: EdgeInsets.symmetric(horizontal: (2 * scale).toDouble()),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
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
          ),
          Text(
            'd',
            style: TextStyle(
              fontSize: 40.sp(context),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RayBurst extends StatelessWidget {
  final double diameter;
  final Color color;
  final int rays;
  final double sweepDegrees;
  final double startDegrees;

  const _RayBurst({
    required this.diameter,
    required this.color,
    required this.rays,
    required this.sweepDegrees,
    this.startDegrees = -90,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: diameter.w(context),
      height: diameter.w(context),
      child: CustomPaint(
        painter: _RayBurstPainter(
          color: color,
          rays: rays,
          sweepRadians: sweepDegrees * math.pi / 180,
          startRadians: startDegrees * math.pi / 180,
        ),
      ),
    );
  }
}

class _RayBurstPainter extends CustomPainter {
  final Color color;
  final int rays;
  final double sweepRadians;
  final double startRadians;

  _RayBurstPainter({
    required this.color,
    required this.rays,
    required this.sweepRadians,
    required this.startRadians,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final double step = sweepRadians / rays;

    for (int i = 0; i < rays; i++) {
      final double start = startRadians + (i * step);
      final double end = start + step * 0.8;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          start,
          end - start,
          false,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
