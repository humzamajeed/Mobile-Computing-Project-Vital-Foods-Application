import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Interactive Tracking Screen with Expandable Bottom Sheet
/// Shows order tracking with draggable bottom sheet
class InteractiveTrackingScreen extends StatefulWidget {
  const InteractiveTrackingScreen({super.key});

  @override
  State<InteractiveTrackingScreen> createState() =>
      _InteractiveTrackingScreenState();
}

class _InteractiveTrackingScreenState extends State<InteractiveTrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _showCallOptions() {
    Navigator.pushNamed(context, '/delivery-call');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Map area
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(AppAssets.mapTracking, fit: BoxFit.cover),
                ),
              ],
            ),
          ),

          // Animated Bottom Sheet
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final sheetHeight = _isExpanded
                  ? context.screenHeight * 0.65
                  : 280.0.h(context);

              return Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: sheetHeight,
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! < -500) {
                      // Swiped up - expand
                      if (!_isExpanded) _toggleSheet();
                    } else if (details.primaryVelocity! > 500) {
                      // Swiped down - collapse
                      if (_isExpanded) _toggleSheet();
                    }
                  },
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
                    child: Column(
                      children: [
                        // Handle bar - tappable
                        GestureDetector(
                          onTap: _toggleSheet,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h(context),
                            ),
                            child: Center(
                              child: Container(
                                width: 40.w(context),
                                height: 4.h(context),
                                decoration: BoxDecoration(
                                  color: AppColors.borderDark,
                                  borderRadius: BorderRadius.circular(
                                    2.w(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Content
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w(context),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!_isExpanded) ...[
                                  // Collapsed view - basic info
                                  _buildCollapsedContent(context, loc),
                                ] else ...[
                                  // Expanded view - full details
                                  _buildExpandedContent(context, loc),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 109.h(context),
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
                            color: Colors.white,
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
                              fontWeight: FontWeight
                                  .w700, // Made bold for better visibility
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

  Widget _buildCollapsedContent(BuildContext context, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status
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
          'Your order is on the way',
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 14.w(context),
            color: AppColors.mutedGrayDark,
          ),
        ),

        SizedBox(height: 24.h(context)),

        // Progress dots
        Row(
          children: [
            _buildProgressDot(context, true),
            Expanded(
              child: Container(height: 2.h(context), color: AppColors.primary),
            ),
            _buildProgressDot(context, true),
            Expanded(
              child: Container(height: 2.h(context), color: AppColors.primary),
            ),
            _buildProgressDot(context, false),
            Expanded(
              child: Container(
                height: 2.h(context),
                color: AppColors.handleGray,
              ),
            ),
            _buildProgressDot(context, false),
          ],
        ),

        SizedBox(height: 24.h(context)),

        // Tap to expand hint
        Center(
          child: Column(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                size: 24.w(context),
                color: AppColors.mutedGrayDark,
              ),
              Text(
                'Swipe up for details',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 12.w(context),
                  color: AppColors.mutedGrayDark,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h(context)),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status
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
          padding: EdgeInsets.symmetric(
            horizontal: 14.w(context),
            vertical: 14.h(context),
          ),
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
                  image: DecorationImage(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h(context)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                        SizedBox(width: 8.w(context)),
                        Flexible(
                          child: Text(
                            '234 ${loc.deliveries}',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 13.w(context),
                              color: AppColors.mutedGrayDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                  width: 42.w(context),
                  height: 42.h(context),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 20.w(context),
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              SizedBox(width: 10.w(context)),

              // Call button
              GestureDetector(
                onTap: _showCallOptions,
                child: Container(
                  width: 42.w(context),
                  height: 42.h(context),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone,
                    size: 22.w(context),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 32.h(context)),

        // Delivery address
        Text(
          loc.deliveryAddress,
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

        SizedBox(height: 32.h(context)),

        // Order details
        Text(
          'Order Details',
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 16.w(context),
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),

        SizedBox(height: 16.h(context)),

        _buildOrderItem(context, '2x Pizza Calzone', '\$64'),
        SizedBox(height: 12.h(context)),
        _buildOrderItem(context, '1x Burger Bistro', '\$40'),

        SizedBox(height: 32.h(context)),
      ],
    );
  }

  Widget _buildProgressDot(BuildContext context, bool isActive) {
    return Container(
      width: 12.w(context),
      height: 12.h(context),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.handleGray,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 14.w(context),
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 14.w(context),
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
