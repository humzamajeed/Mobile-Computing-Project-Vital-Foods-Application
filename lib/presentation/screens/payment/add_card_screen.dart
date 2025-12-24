import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';

/// Add Card Screen - Form to add a new payment card
/// Design: Figma node-id=190:1773
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController(
    text: 'Vishal Khadok',
  );
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
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
            Icons.close,
            size: 20.w(context),
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          loc.addCard,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 17.sp(context),
            color: AppColors.textPrimaryDeep,
            height: 22 / 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h(context)),

            // Card Holder Name
            Text(
              loc.cardholderName.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 14.sp(context),
                color: AppColors.textHint,
                height: 24 / 14,
              ),
            ),
            SizedBox(height: 8.h(context)),
            Container(
              width: double.infinity,
              height: 61.95.h(context),
              decoration: BoxDecoration(
                color: AppColors.surfaceF6,
                borderRadius: BorderRadius.circular(10.w(context)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
              child: TextField(
                controller: _cardHolderController,
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.sp(context),
                  color: AppColors.textDark.withValues(alpha: 0.9),
                ),
                decoration: InputDecoration(
                  hintText: 'Vishal Khadok',
                  hintStyle: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.sp(context),
                    color: const Color(0xFF32343E).withValues(alpha: 0.9),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 20.h(context)),
                ),
              ),
            ),

            SizedBox(height: 20.h(context)),

            // Card Number
            Text(
              loc.cardNumber.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 14.sp(context),
                color: AppColors.textHint,
                height: 24 / 14,
              ),
            ),
            SizedBox(height: 8.h(context)),
            Container(
              width: double.infinity,
              height: 62.h(context),
              decoration: BoxDecoration(
                color: AppColors.surfaceF6,
                borderRadius: BorderRadius.circular(10.w(context)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
              child: TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.sp(context),
                  color: AppColors.textDark.withValues(alpha: 0.9),
                ),
                decoration: InputDecoration(
                  hintText: '2134 L _ _ _ _   _ _ _ _',
                  hintStyle: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.sp(context),
                    color: const Color(0xFF32343E).withValues(alpha: 0.9),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 20.h(context)),
                ),
              ),
            ),

            SizedBox(height: 20.h(context)),

            // Expire Date and CVC Row
            Row(
              children: [
                // Expire Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.expiryDate.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.sp(context),
                          color: AppColors.textHint,
                          height: 24 / 14,
                        ),
                      ),
                      SizedBox(height: 8.h(context)),
                      Container(
                        height: 62.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceF6,
                          borderRadius: BorderRadius.circular(10.w(context)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w(context),
                        ),
                        child: TextField(
                          controller: _expiryController,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.sp(context),
                            color: AppColors.textDark.withValues(alpha: 0.5),
                          ),
                          decoration: InputDecoration(
                            hintText: 'mm/yyyy',
                            hintStyle: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 16.sp(context),
                              color: const Color(
                                0xFF32343E,
                              ).withValues(alpha: 0.5),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 27.w(context)),

                // CVC
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.cvv.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.sp(context),
                          color: AppColors.textHint,
                          height: 24 / 14,
                        ),
                      ),
                      SizedBox(height: 8.h(context)),
                      Container(
                        height: 62.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceF6,
                          borderRadius: BorderRadius.circular(10.w(context)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w(context),
                        ),
                        child: TextField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.sp(context),
                            color: AppColors.textDark.withValues(alpha: 0.5),
                          ),
                          decoration: InputDecoration(
                            hintText: '***',
                            hintStyle: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 16.sp(context),
                              color: const Color(
                                0xFF32343E,
                              ).withValues(alpha: 0.5),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h(context)),

            // Add & Make Payment button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('ADD & MAKE PAYMENT button tapped');
                if (_cardHolderController.text.isNotEmpty &&
                    _cardNumberController.text.isNotEmpty &&
                    _expiryController.text.isNotEmpty &&
                    _cvvController.text.isNotEmpty) {
                  debugPrint(
                    'Card details valid, navigating to payment processing',
                  );
                  if (context.mounted) {
                    // Navigate to payment processing screen
                    Navigator.pushReplacementNamed(
                      context,
                      '/payment-processing',
                    );
                  }
                } else {
                  debugPrint('Card details incomplete');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loc.pleaseAddCardFirst),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 62.h(context),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.w(context)),
                ),
                child: Center(
                  child: Text(
                    '${loc.addCard.toUpperCase()} & ${loc.payNow.toUpperCase()}',
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

            SizedBox(height: 20.h(context)),
          ],
        ),
      ),
    );
  }
}
