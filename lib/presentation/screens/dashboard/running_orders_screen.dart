import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Running Orders Screen (Figma node 601-1772)
class RunningOrdersScreen extends StatelessWidget {
  const RunningOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w(context),
                vertical: 16.h(context),
              ),
              children: [
                Text(
                  '20 Running Orders',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 16.sp(context),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h(context)),
                _buildOrderItem(
                  context,
                  name: 'Chicken Thai Biriyani',
                  orderId: '32053',
                  price: 60,
                ),
                SizedBox(height: 12.h(context)),
                _buildOrderItem(
                  context,
                  name: 'Chicken Bhuna',
                  orderId: '15253',
                  price: 30,
                ),
                SizedBox(height: 12.h(context)),
                _buildOrderItem(
                  context,
                  name: 'Vegetarian Poutine',
                  orderId: '21200',
                  price: 35,
                ),
                SizedBox(height: 12.h(context)),
                _buildOrderItem(
                  context,
                  name: 'Turkey Bacon Strips',
                  orderId: '53241',
                  price: 45,
                ),
                SizedBox(height: 12.h(context)),
                _buildOrderItem(
                  context,
                  name: 'Veggie Burrito',
                  orderId: '48464',
                  price: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.h(context),
        bottom: 12.h(context),
        left: 20.w(context),
        right: 20.w(context),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.textSecondary,
            AppColors.textSecondary.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.menu_rounded,
                  size: 24.w(context),
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 16.w(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOCATION',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 11.sp(context),
                        letterSpacing: 0.5,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h(context)),
                    Row(
                      children: [
                        Text(
                          'Halal Lab office',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14.sp(context),
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 20.w(context),
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 40.w(context),
                height: 40.w(context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceF6,
                ),
                child: Icon(
                  Icons.person,
                  size: 20.w(context),
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h(context)),
          Row(
            children: [
              Expanded(child: _buildStatCard(context, '20', 'RUNNING ORDERS')),
              SizedBox(width: 12.w(context)),
              Expanded(child: _buildStatCard(context, '05', 'ORDER REQUEST')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 18.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.w(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 28.sp(context),
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6.h(context)),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11.sp(context),
              color: AppColors.textHint,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(
    BuildContext context, {
    required String name,
    required String orderId,
    required int price,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.w(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70.w(context),
            height: 70.w(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.w(context)),
              color: AppColors.surfaceF6,
            ),
            child: CustomNetworkImage(
              imageUrl: AppData.getFoodImage(price), // Random image
              fit: BoxFit.cover,
              width: 70.w(context),
              height: 70.w(context),
              borderRadius: 14.w(context),
            ),
          ),
          SizedBox(width: 12.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#Breakfast',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 11.sp(context),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h(context)),
                Text(
                  name,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontSize: 14.sp(context),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h(context)),
                Text(
                  'ID: $orderId',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12.sp(context),
                    color: AppColors.textHint,
                  ),
                ),
                SizedBox(height: 6.h(context)),
                Text(
                  '\$$price',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 16.sp(context),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w(context)),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w(context),
                    vertical: 8.h(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.w(context)),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Done',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 13.sp(context),
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 6.h(context)),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w(context),
                    vertical: 8.h(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.w(context)),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 13.sp(context),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
