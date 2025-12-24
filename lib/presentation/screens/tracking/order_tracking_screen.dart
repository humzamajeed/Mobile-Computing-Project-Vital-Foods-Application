import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/data/app_data.dart';
import '../../../core/extensions/size_extensions.dart';
import '../../widgets/custom_network_image.dart';

/// Order Tracking Screen
/// Design: Figma node-id=149:1161
class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(loc.trackOrder),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Full Screen Map Background
          Positioned.fill(
            child: Image.asset(AppAssets.mapTracking, fit: BoxFit.cover),
          ),

          // Content
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20.w(context)),
                  children: [
                    // Order ID and Status
                    Container(
                      padding: EdgeInsets.all(16.w(context)),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                loc.orderNumber('162432'),
                                style: AppTextStyles.titleMedium,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w(context),
                                  vertical: 4.h(context),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.warning.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusS,
                                  ),
                                ),
                                child: Text(
                                  loc.onTheWay,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h(context)),
                          Text(
                            loc.estimatedDelivery('25-30 min'),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h(context)),

                    // Delivery Person Info
                    Container(
                      padding: EdgeInsets.all(16.w(context)),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.deliveryPerson,
                            style: AppTextStyles.titleMedium,
                          ),
                          SizedBox(height: 12.h(context)),
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: AppData.getUserImage(0),
                                width: 60.w(context),
                                height: 60.w(context),
                                borderRadius: 30.w(context),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 12.w(context)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'John Doe',
                                      style: AppTextStyles.titleSmall,
                                    ),
                                    SizedBox(height: 4.h(context)),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: AppColors.warning,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4.w(context)),
                                        Text(
                                          '4.8',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        SizedBox(width: 4.w(context)),
                                        Text(
                                          loc.reviewsCount(234),
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.phone_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chat_bubble_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h(context)),

                    // Order Timeline
                    Container(
                      padding: EdgeInsets.all(16.w(context)),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Status',
                            style: AppTextStyles.titleMedium,
                          ),
                          SizedBox(height: 16.h(context)),
                          _buildTimelineItem(
                            icon: Icons.check_circle_rounded,
                            title: 'Order Placed',
                            subtitle: '29 Jan, 12:30 PM',
                            isCompleted: true,
                            isLast: false,
                          ),
                          _buildTimelineItem(
                            icon: Icons.restaurant_rounded,
                            title: 'Order Confirmed',
                            subtitle: '29 Jan, 12:35 PM',
                            isCompleted: true,
                            isLast: false,
                          ),
                          _buildTimelineItem(
                            icon: Icons.delivery_dining_rounded,
                            title: 'Order Picked Up',
                            subtitle: '29 Jan, 12:45 PM',
                            isCompleted: true,
                            isLast: false,
                          ),
                          _buildTimelineItem(
                            icon: Icons.location_on_rounded,
                            title: 'On the Way',
                            subtitle: 'Estimated arrival: 1:00 PM',
                            isCompleted: false,
                            isLast: false,
                          ),
                          _buildTimelineItem(
                            icon: Icons.home_rounded,
                            title: 'Delivered',
                            subtitle: 'Pending',
                            isCompleted: false,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Cancel Button
              Container(
                padding: EdgeInsets.all(20.w(context)),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _showCancelOrderDialog();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h(context)),
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                      child: Text(loc.cancelOrder),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40.w(context),
              height: 40.w(context),
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.primary
                    : AppColors.backgroundGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isCompleted ? AppColors.white : AppColors.textSecondary,
                size: 20.w(context),
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w(context),
                height: 40.h(context),
                color: isCompleted ? AppColors.primary : AppColors.divider,
              ),
          ],
        ),
        SizedBox(width: 12.w(context)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: isCompleted
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h(context)),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelOrderDialog() {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(loc.cancelOrderQuestion),
        content: Text(loc.cancelOrderCannotUndone),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.noKeepOrder),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(loc.yesCancel),
          ),
        ],
      ),
    );
  }
}
