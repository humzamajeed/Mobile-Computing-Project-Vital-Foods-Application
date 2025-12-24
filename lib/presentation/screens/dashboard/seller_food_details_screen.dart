import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Seller Food Details Screen (Figma node 601-1774)
class SellerFoodDetailsScreen extends StatelessWidget {
  final String? foodName;
  final int? price;
  final String? category;

  const SellerFoodDetailsScreen({
    super.key,
    this.foodName,
    this.price,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildFoodImage(context),
                  Padding(
                    padding: EdgeInsets.all(20.w(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(context),
                        SizedBox(height: 20.h(context)),
                        _buildIngredientsSection(context),
                        SizedBox(height: 20.h(context)),
                        _buildDescriptionSection(context),
                        SizedBox(height: 80.h(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.h(context),
        bottom: 12.h(context),
        left: 20.w(context),
        right: 20.w(context),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.w(context),
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(width: 16.w(context)),
          Expanded(
            child: Text(
              'Food Details',
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: 16.sp(context),
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.addNewFood),
            child: Text(
              'EDIT',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14.sp(context),
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w(context)),
      height: 240.h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w(context)),
        color: AppColors.surfaceF6,
      ),
      child: Stack(
        children: [
          CustomNetworkImage(
            imageUrl: AppData.getFoodImage(
              (foodName?.length ?? 0) + 1,
            ), // Deterministic random image
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            borderRadius: 20.w(context),
          ),
          Positioned(
            left: 16.w(context),
            bottom: 16.h(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w(context),
                vertical: 6.h(context),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.w(context)),
              ),
              child: Text(
                category ?? 'Breakfast',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16.w(context),
            bottom: 16.h(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w(context),
                vertical: 8.h(context),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.w(context)),
              ),
              child: Text(
                'Delivery',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                foodName ?? 'Chicken Thai Biriyani',
                style: AppTextStyles.titleLarge.copyWith(
                  fontSize: 18.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '\$${price ?? 60}',
              style: AppTextStyles.titleLarge.copyWith(
                fontSize: 20.sp(context),
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h(context)),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14.w(context),
              color: AppColors.textHint,
            ),
            SizedBox(width: 4.w(context)),
            Text(
              'Kentucky 39495',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12.sp(context),
                color: AppColors.textHint,
              ),
            ),
            SizedBox(width: 16.w(context)),
            Icon(Icons.star, size: 14.w(context), color: AppColors.star),
            SizedBox(width: 4.w(context)),
            Text(
              '4.9',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12.sp(context),
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.w(context)),
            Text(
              '(10 Reviews)',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12.sp(context),
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIngredientsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INGREDIENTS',
          style: AppTextStyles.labelMedium.copyWith(
            fontSize: 13.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12.h(context)),
        Wrap(
          spacing: 12.w(context),
          runSpacing: 12.h(context),
          children: [
            _buildIngredientItem(context, Icons.restaurant, 'Salt'),
            _buildIngredientItem(context, Icons.set_meal_rounded, 'Chicken'),
            _buildIngredientItem(context, Icons.spa_rounded, 'Onion\n(many)'),
            _buildIngredientItem(context, Icons.eco_rounded, 'Garlic'),
            _buildIngredientItem(
              context,
              Icons.local_fire_department_rounded,
              'Peppers\n(mild)',
            ),
            _buildIngredientItem(context, Icons.grass_rounded, 'Ginger'),
            _buildIngredientItem(
              context,
              Icons.energy_savings_leaf_rounded,
              'Broccoli',
            ),
            _buildIngredientItem(context, Icons.circle_outlined, 'Orange'),
            _buildIngredientItem(context, Icons.nature_rounded, 'Walnut'),
          ],
        ),
      ],
    );
  }

  Widget _buildIngredientItem(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Column(
      children: [
        Container(
          width: 52.w(context),
          height: 52.w(context),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24.w(context), color: AppColors.primary),
        ),
        SizedBox(height: 6.h(context)),
        SizedBox(
          width: 52.w(context),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10.sp(context),
              color: AppColors.textHint,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyles.titleSmall.copyWith(
            fontSize: 15.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h(context)),
        Text(
          'Lorem Ipsum dolor sit amet, consectetur Notori adipiscing elit. Donec porttitor lobortis dui mauris turpis.',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 13.sp(context),
            color: AppColors.textHint,
            height: 1.6,
          ),
        ),
      ],
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
          GestureDetector(
            onTap: () => Navigator.of(context).popUntil(
              (route) =>
                  route.settings.name == AppRoutes.sellerDashboard ||
                  route.isFirst,
            ),
            child: _buildNavIcon(Icons.grid_view_rounded, true),
          ),
          _buildNavIcon(Icons.menu_rounded, false),
          _buildCenterAction(),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.sellerNotifications),
            child: _buildNavIcon(Icons.notifications_none_rounded, false),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.sellerProfile),
            child: _buildNavIcon(Icons.person_outline_rounded, false),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, bool active) {
    return Builder(
      builder: (context) {
        final color = active ? AppColors.primary : AppColors.textHint;
        return Container(
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
      },
    );
  }

  Widget _buildCenterAction() {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.addNewFood),
          child: Container(
            width: 54.w(context),
            height: 54.w(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              color: AppColors.white,
            ),
            child: Icon(
              Icons.add,
              color: AppColors.primary,
              size: 26.w(context),
            ),
          ),
        );
      },
    );
  }
}
