import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Tracking Order Screen 2 - On the Way Stage
/// Shows delivery person info, map, and real-time tracking
class TrackingOrder2Screen extends StatelessWidget {
  const TrackingOrder2Screen({super.key});

  void _showCallOptions(BuildContext context) {
    Navigator.pushNamed(context, '/delivery-call');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Map area
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 400.h(context),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(AppAssets.mapTracking, fit: BoxFit.cover),
                ),
                // Delivery icon on map
                Positioned(
                  top: 150.h(context),
                  left: context.screenWidth / 2 - 20.w(context),
                  child: Icon(
                    Icons.delivery_dining,
                    size: 40.w(context),
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Bottom sheet
          Positioned(
            top: 350.h(context),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.w(context)),
                  topRight: Radius.circular(24.w(context)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40.w(context),
                        height: 4.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.handleGray,
                          borderRadius: BorderRadius.circular(2.w(context)),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h(context)),

                    // Delivery status
                    Row(
                      children: [
                        Container(
                          width: 12.w(context),
                          height: 12.h(context),
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w(context)),
                        Text(
                          'On the Way',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '10 min',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h(context)),

                    Text(
                      'Your order is on the way to your location',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 14.w(context),
                        color: AppColors.mutedGrayDark,
                      ),
                    ),

                    SizedBox(height: 32.h(context)),

                    // Delivery person card
                    Container(
                      padding: EdgeInsets.all(16.w(context)),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceF6,
                        borderRadius: BorderRadius.circular(12.w(context)),
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          Container(
                            width: 60.w(context),
                            height: 60.h(context),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage(AppAssets.deliveryPerson),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(width: 16.w(context)),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Doe',
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 16.w(context),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4.h(context)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14.w(context),
                                      color: AppColors.star,
                                    ),
                                    SizedBox(width: 4.w(context)),
                                    Text(
                                      '4.8',
                                      style: TextStyle(
                                        fontFamily: 'Sen',
                                        fontSize: 14.w(context),
                                        color: AppColors.mutedGrayDark,
                                      ),
                                    ),
                                    SizedBox(width: 12.w(context)),
                                    Text(
                                      '234 deliveries',
                                      style: TextStyle(
                                        fontFamily: 'Sen',
                                        fontSize: 14.w(context),
                                        color: AppColors.mutedGrayDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Chat button
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/delivery-message');
                            },
                            child: Container(
                              width: 45.w(context),
                              height: 45.h(context),
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat_bubble_outline,
                                size: 22.w(context),
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w(context)),

                          // Call button
                          GestureDetector(
                            onTap: () => _showCallOptions(context),
                            child: Container(
                              width: 45.w(context),
                              height: 45.h(context),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone,
                                size: 22.w(context),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h(context)),

                    // Delivery address
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 16.h(context)),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 24.w(context),
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 12.w(context)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Home',
                                style: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 14.w(context),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4.h(context)),
                              Text(
                                '2118 Thornridge Cir. Syracuse',
                                style: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 14.w(context),
                                  color: AppColors.mutedGrayDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
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
                            color: AppColors.white,
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
                              color: AppColors.white,
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
}
