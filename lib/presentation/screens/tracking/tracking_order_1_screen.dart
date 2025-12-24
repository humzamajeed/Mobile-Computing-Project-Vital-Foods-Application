import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Tracking Order Screen 1 - Order Placed/Preparing Stage
/// Shows order details and initial preparation status
class TrackingOrder1Screen extends StatelessWidget {
  const TrackingOrder1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 109.h(context)),

                // Map placeholder
                Container(
                  width: context.screenWidth,
                  height: 300.h(context),
                  color: AppColors.mapGray,
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.location_on,
                          size: 80.w(context),
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(24.w(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Estimated time
                      Center(
                        child: Column(
                          children: [
                            Text(
                              '15 Min',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 32.w(context),
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h(context)),
                            Text(
                              'Estimated Delivery Time',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.mutedGrayDark,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h(context)),

                      // Status divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4.h(context),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  2.w(context),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w(context)),
                          Expanded(
                            child: Container(
                              height: 4.h(context),
                              decoration: BoxDecoration(
                                color: AppColors.handleGray,
                                borderRadius: BorderRadius.circular(
                                  2.w(context),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w(context)),
                          Expanded(
                            child: Container(
                              height: 4.h(context),
                              decoration: BoxDecoration(
                                color: AppColors.handleGray,
                                borderRadius: BorderRadius.circular(
                                  2.w(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h(context)),

                      // Order Status
                      Text(
                        'Your Order',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 20.w(context),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 24.h(context)),

                      // Status steps
                      _buildStatusStep(
                        context,
                        Icons.receipt_long,
                        'Order Placed',
                        'We have received your order',
                        true,
                        false,
                      ),

                      _buildStatusStep(
                        context,
                        Icons.restaurant,
                        'Order Confirmed',
                        'Your order has been confirmed',
                        true,
                        false,
                      ),

                      _buildStatusStep(
                        context,
                        Icons.soup_kitchen,
                        'Order is Being Prepared',
                        'Restaurant is preparing your food',
                        false,
                        false,
                      ),

                      _buildStatusStep(
                        context,
                        Icons.delivery_dining,
                        'Out for Delivery',
                        'Your order is on the way',
                        false,
                        true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 109.h(context),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        child: Container(
                          width: 45.w(context),
                          height: 45.w(context),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(14.w(context)),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20.w(context),
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Track Order',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 17.w(context),
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 45.w(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusStep(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool isCompleted,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40.w(context),
              height: 40.h(context),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : AppColors.handleGray,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : icon,
                size: 20.w(context),
                color: isCompleted ? AppColors.white : AppColors.mutedGrayDark,
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w(context),
                height: 40.h(context),
                color: AppColors.handleGray,
              ),
          ],
        ),
        SizedBox(width: 16.w(context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.w(context),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h(context)),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 14.w(context),
                  color: AppColors.mutedGrayDark,
                ),
              ),
              if (!isLast) SizedBox(height: 24.h(context)),
            ],
          ),
        ),
      ],
    );
  }
}
