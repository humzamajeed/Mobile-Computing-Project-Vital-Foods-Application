import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';
import 'package:finalproject/presentation/providers/cart_provider.dart';

/// Payment Processing Screen - Similar to payment screen
/// Design: Figma node-id=601-1664
/// Appears after adding card details and before payment success
class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  String _selectedPaymentMethod = 'mastercard';
  final Map<String, dynamic>? _savedCard;

  _PaymentProcessingScreenState()
    : _savedCard = {
        'cardNumber': '************ 436',
        'cardHolder': 'Vishal Khadok',
        'expiry': '12/25',
      };

  @override
  void initState() {
    super.initState();
    // Static page - no auto-navigation
  }

  void _placeOrder() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/payment-success',
      (route) => route.settings.name == AppRoutes.home || route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.w(context),
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          loc.paymentMethod,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 17.sp(context),
            color: AppColors.textPrimaryDeep,
            height: 22 / 17,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final total = cartProvider.totalPrice;

          return Column(
            children: [
              // Scrollable payment methods section
              Padding(
                padding: EdgeInsets.only(
                  top: 40.h(context),
                  left: 24.w(context),
                  right: 24.w(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment methods - Horizontal scrollable
                    SizedBox(
                      height: 100.h(context),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _PaymentMethodIcon(
                            type: 'cash',
                            label: loc.cash,
                            isSelected: _selectedPaymentMethod == 'cash',
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'cash';
                              });
                            },
                          ),
                          SizedBox(width: 12.w(context)),
                          _PaymentMethodIcon(
                            type: 'visa',
                            label: 'Visa',
                            isSelected: _selectedPaymentMethod == 'visa',
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'visa';
                              });
                            },
                          ),
                          SizedBox(width: 12.w(context)),
                          _PaymentMethodIcon(
                            type: 'mastercard',
                            label: 'Mastercard',
                            isSelected: _selectedPaymentMethod == 'mastercard',
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'mastercard';
                              });
                            },
                          ),
                          SizedBox(width: 12.w(context)),
                          _PaymentMethodIcon(
                            type: 'paypal',
                            label: 'PayPal',
                            isSelected: _selectedPaymentMethod == 'paypal',
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'paypal';
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h(context)),

                    // Saved card dropdown (card was just added)
                    Container(
                      width: double.infinity,
                      height: 62.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceF6,
                        borderRadius: BorderRadius.circular(12.w(context)),
                        border: Border.all(
                          color: AppColors.borderDark,
                          width: 1.w(context),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'mastercard',
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: const Color(0xFF32343E),
                            size: 24.w(context),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w(context),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: 'mastercard',
                              child: Row(
                                children: [
                                  // Mastercard logo
                                  Container(
                                    width: 40.w(context),
                                    height: 24.h(context),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.brandMastercardRed,
                                          AppColors.brandMastercardOrange,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        4.w(context),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'MC',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp(context),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w(context)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Master Card',
                                          style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontSize: 14.sp(context),
                                            color: const Color(0xFF32343E),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 2.h(context)),
                                        Text(
                                          _savedCard!['cardNumber'] ??
                                              '************ 436',
                                          style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontSize: 16.sp(context),
                                            color: const Color(0xFF32343E),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Spacer to push bottom section down
              const Spacer(),

              // Fixed bottom section
              Container(
                padding: EdgeInsets.only(
                  left: 24.w(context),
                  right: 24.w(context),
                  top: 24.h(context),
                  bottom: MediaQuery.of(context).padding.bottom + 24.h(context),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Total
                    Row(
                      children: [
                        Text(
                          'TOTAL: ',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.sp(context),
                            color: AppColors.textHint,
                            height: 24 / 14,
                          ),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 30.sp(context),
                            color: AppColors.textPrimaryDeep,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h(context)),

                    // Pay & Confirm button
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _placeOrder,
                      child: Container(
                        width: double.infinity,
                        height: 62.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12.w(context)),
                        ),
                        child: Center(
                          child: Text(
                            'PAY & CONFIRM',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 14.sp(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              letterSpacing: 0.5.w(context),
                            ),
                          ),
                        ),
                      ),
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
}

class _PaymentMethodIcon extends StatelessWidget {
  final String type;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodIcon({
    required this.type,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 85.w(context),
                height: 72.h(context),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.surfaceF6,
                  borderRadius: BorderRadius.circular(12.w(context)),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.primary,
                          width: 2.w(context),
                        )
                      : null,
                ),
                child: _buildPaymentIcon(context),
              ),
              if (isSelected)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 20.w(context),
                    height: 20.w(context),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 12.w(context),
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h(context)),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.sp(context),
              color: AppColors.mutedGrayDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(BuildContext context) {
    switch (type) {
      case 'cash':
        return Icon(
          Icons.money,
          size: 32.w(context),
          color: isSelected ? AppColors.primary : const Color(0xFF464E57),
        );
      case 'visa':
        return Container(
          padding: EdgeInsets.all(8.w(context)),
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/200px-Visa_Inc._logo.svg.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.brandVisaDark, AppColors.brandVisaBlue],
                  ),
                  borderRadius: BorderRadius.circular(4.w(context)),
                ),
                child: Center(
                  child: Text(
                    'VISA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp(context),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.w(context),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      case 'mastercard':
        return Container(
          padding: EdgeInsets.all(8.w(context)),
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/200px-Mastercard-logo.svg.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.brandMastercardRed,
                      AppColors.brandMastercardOrange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4.w(context)),
                ),
                child: Center(
                  child: Text(
                    'MC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      case 'paypal':
        return Container(
          padding: EdgeInsets.all(8.w(context)),
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/200px-PayPal.svg.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.brandPaypalBlue,
                  borderRadius: BorderRadius.circular(4.w(context)),
                ),
                child: Center(
                  child: Text(
                    'PP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      default:
        return Icon(
          Icons.payment,
          size: 32.w(context),
          color: isSelected ? AppColors.primary : const Color(0xFF464E57),
        );
    }
  }
}
