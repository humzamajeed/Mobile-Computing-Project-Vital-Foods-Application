import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// My Food List Screen - Seller's food menu management (Figma node 601-1775)
class MyFoodListScreen extends StatefulWidget {
  const MyFoodListScreen({super.key});

  @override
  State<MyFoodListScreen> createState() => _MyFoodListScreenState();
}

class _MyFoodListScreenState extends State<MyFoodListScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: _buildBottomNav(context),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.w(context),
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Food List',
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w(context),
                vertical: 12.h(context),
              ),
              child: Row(
                children: [
                  _buildCategoryTab('All'),
                  SizedBox(width: 12.w(context)),
                  _buildCategoryTab('Breakfast'),
                  SizedBox(width: 12.w(context)),
                  _buildCategoryTab('Lunch'),
                  SizedBox(width: 12.w(context)),
                  _buildCategoryTab('Dinner'),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w(context),
              vertical: 16.h(context),
            ),
            child: Text(
              'Total 03 Items',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 13.sp(context),
                color: AppColors.textHint,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
              itemCount: 3,
              separatorBuilder: (context, index) =>
                  SizedBox(height: 12.h(context)),
              itemBuilder: (context, index) {
                final name = index == 0
                    ? 'Chicken Thai Biriyani'
                    : index == 1
                    ? 'Chicken Bhuna'
                    : 'Mazalichiken Halim';
                final price = index == 0
                    ? 60
                    : index == 1
                    ? 30
                    : 25;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.sellerFoodDetails,
                      arguments: {
                        'foodName': name,
                        'price': price,
                        'category': 'Breakfast',
                      },
                    );
                  },
                  child: _FoodItem(
                    name: name,
                    category: 'Breakfast',
                    price: price,
                    rating: 4.9,
                    reviewCount: 10,
                    imageUrl: AppData.getFoodImage(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18.w(context),
          vertical: 8.h(context),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          borderRadius: BorderRadius.circular(20.w(context)),
        ),
        child: Text(
          category,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.sp(context),
            color: isSelected ? AppColors.white : AppColors.textHint,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 22.w(context),
        vertical: 12.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavIcon(
            icon: Icons.grid_view_rounded,
            onTap: () => Navigator.pop(context),
          ),
          _NavIcon(icon: Icons.menu_rounded, active: true),
          _CenterAction(
            onTap: () => Navigator.pushNamed(context, AppRoutes.addNewFood),
          ),
          _NavIcon(
            icon: Icons.notifications_none_rounded,
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.sellerNotifications),
          ),
          _NavIcon(
            icon: Icons.person_outline_rounded,
            onTap: () => Navigator.pushNamed(context, AppRoutes.sellerProfile),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback? onTap;

  const _NavIcon({required this.icon, this.active = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textHint;
    final iconWidget = Container(
      width: 44.w(context),
      height: 44.w(context),
      decoration: BoxDecoration(
        color: active
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 22.w(context)),
    );
    if (onTap == null) return iconWidget;
    return GestureDetector(onTap: onTap, child: iconWidget);
  }
}

class _CenterAction extends StatelessWidget {
  final VoidCallback onTap;

  const _CenterAction({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54.w(context),
        height: 54.w(context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
          color: AppColors.white,
        ),
        child: Icon(Icons.add, color: AppColors.primary, size: 26.w(context)),
      ),
    );
  }
}

class _FoodItem extends StatelessWidget {
  final String name;
  final String category;
  final int price;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  const _FoodItem({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
            width: 80.w(context),
            height: 80.w(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w(context)),
              color: AppColors.surfaceF6,
            ),
            child: CustomNetworkImage(
              imageUrl: imageUrl,
              width: 80.w(context),
              height: 80.w(context),
              borderRadius: 16.w(context),
            ),
          ),
          SizedBox(width: 12.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 15.sp(context),
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      size: 22.w(context),
                      color: AppColors.textHint,
                    ),
                  ],
                ),
                SizedBox(height: 6.h(context)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w(context),
                    vertical: 4.h(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.w(context)),
                  ),
                  child: Text(
                    category,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11.sp(context),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 8.h(context)),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 14.w(context),
                      color: AppColors.star,
                    ),
                    SizedBox(width: 4.w(context)),
                    Text(
                      '$rating',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12.sp(context),
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6.w(context)),
                    Text(
                      '($reviewCount Review)',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12.sp(context),
                        color: AppColors.textHint,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Pick UP',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12.sp(context),
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 28.h(context)),
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
        ],
      ),
    );
  }
}
