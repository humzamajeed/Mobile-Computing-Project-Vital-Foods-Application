import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/presentation/providers/cart_provider.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/presentation/providers/order_provider.dart';

/// Payment Success Screen - Shows payment confirmation
/// Design: Figma node-id=190-885
/// Exact Dimensions from Figma:
/// - Screen: 375x812px
/// - Success illustration in center
/// - Congratulations message
/// - Track Order button at bottom
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Get actual screen size

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h(context)),

                // Success illustration with wallet and sparkles
                SizedBox(
                  width: 280.w(context),
                  height: 280.h(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Sparkles around the wallet
                      ...List.generate(8, (index) {
                        final angle = (index * 45) * 3.14159 / 180;
                        final radius = 120.w(context);
                        return Positioned(
                          left:
                              140.w(context) +
                              radius *
                                  (angle == 0
                                      ? 1
                                      : (angle == 3.14159
                                            ? -1
                                            : (angle < 3.14159 ? 1 : -1) *
                                                  (angle % 3.14159 / 3.14159))),
                          top:
                              140.h(context) -
                              radius *
                                  (angle > 1.57 && angle < 4.71 ? 1 : -1) *
                                  0.7,
                          child: _buildSparkle(context, index),
                        );
                      }),
                      // Wallet illustration
                      Center(
                        child: Container(
                          width: 140.w(context),
                          height: 140.w(context),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryGradientStart,
                                AppColors.primary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.w(context)),
                          ),
                          child: Stack(
                            children: [
                              // Wallet flap
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 35.h(context),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primaryGradientMid,
                                        AppColors.primaryGradientStart,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.w(context)),
                                      topRight: Radius.circular(20.w(context)),
                                    ),
                                  ),
                                ),
                              ),
                              // Coins
                              Positioned(
                                top: 25.h(context),
                                right: 20.w(context),
                                child: Transform.rotate(
                                  angle: 0.3,
                                  child: Container(
                                    width: 35.w(context),
                                    height: 35.w(context),
                                    decoration: const BoxDecoration(
                                      color: AppColors.star,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          fontSize: 18.sp(context),
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20.h(context),
                                left: 30.w(context),
                                child: Transform.rotate(
                                  angle: -0.2,
                                  child: Container(
                                    width: 40.w(context),
                                    height: 40.w(context),
                                    decoration: const BoxDecoration(
                                      color: AppColors.star,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          fontSize: 20.sp(context),
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h(context)),

                // Congratulations text
                Text(
                  loc.thankYou,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 28.w(context),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 32 / 24,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16.h(context)),

                // Success message
                Text(
                  loc.yourOrderHasBeenPlaced,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 15.w(context),
                    color: AppColors.mutedGrayDark.withValues(alpha: 0.8),
                    height: 24 / 14,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40.h(context)),

                // Track Order button
                SizedBox(
                  width: 327.w(context),
                  height: 62.h(context),
                  child: ElevatedButton(
                    onPressed: () async {
                      final authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );
                      final cartProvider = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      final orderProvider = Provider.of<OrderProvider>(
                        context,
                        listen: false,
                      );

                      if (authProvider.user != null &&
                          cartProvider.cart != null) {
                        // Show loading
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        // Create order from cart before clearing
                        debugPrint('📦 Creating order from cart...');
                        debugPrint('   - User ID: ${authProvider.user!.id}');
                        debugPrint(
                          '   - Cart items: ${cartProvider.cart!.items.length}',
                        );
                        debugPrint(
                          '   - Total price: ${cartProvider.cart!.totalPrice}',
                        );

                        final order = await orderProvider.createOrder(
                          userId: authProvider.user!.id,
                          cart: cartProvider.cart!,
                          paymentMethod: 'mastercard', // Default payment method
                          estimatedTime: '20 min',
                        );

                        // Dismiss loading
                        if (context.mounted) {
                          Navigator.pop(context);
                        }

                        if (order != null) {
                          debugPrint(
                            '✅ Order created successfully with ID: ${order.id}',
                          );
                          // Clear cart after order is successfully saved
                          await cartProvider.clearCart(authProvider.user!.id);

                          // Navigate to interactive tracking screen
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/interactive-tracking',
                              (route) => route.settings.name == '/home',
                            );
                          }
                        } else {
                          // Show error if order creation failed
                          debugPrint(
                            '❌ Order creation failed: ${orderProvider.errorMessage}',
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  orderProvider.errorMessage ??
                                      'Failed to create order. Please try again.',
                                ),
                                backgroundColor: AppColors.error,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      } else {
                        // Show error if user or cart is null
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Unable to create order. Please try again.',
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w(context)),
                      ),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    child: Text(
                      loc.trackOrder.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSparkle(BuildContext context, int index) {
    final colors = [
      AppColors.primary,
      AppColors.accentYellow,
      AppColors.accentPurple,
      AppColors.accentPeach,
      Colors.pink.shade200,
      Colors.blue.shade200,
    ];
    final sizes = [16.0, 12.0, 14.0, 10.0, 18.0, 12.0, 16.0, 14.0];

    return Icon(
      Icons.star,
      size: sizes[index % sizes.length].w(context),
      color: colors[index % colors.length].withValues(alpha: 0.6),
    );
  }
}
