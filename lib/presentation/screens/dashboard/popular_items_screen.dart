import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/l10n/app_localizations.dart';

class PopularItemsScreen extends StatelessWidget {
  const PopularItemsScreen({super.key});

  // List of popular items with different names, restaurants, prices, and ratings
  static final List<Map<String, dynamic>> _popularItems = [
    {
      'name': 'European Pizza',
      'restaurant': 'Uttora Coffee House',
      'price': 40.0,
      'rating': 4.9,
    },
    {
      'name': 'Classic Burger',
      'restaurant': 'Burger King',
      'price': 35.0,
      'rating': 4.7,
    },
    {
      'name': 'Chicken Biryani',
      'restaurant': 'Spice Garden',
      'price': 55.0,
      'rating': 4.8,
    },
    {
      'name': 'Sushi Platter',
      'restaurant': 'Tokyo Express',
      'price': 65.0,
      'rating': 4.9,
    },
    {
      'name': 'Grilled Steak',
      'restaurant': 'Steak House',
      'price': 75.0,
      'rating': 4.6,
    },
    {
      'name': 'Margherita Pizza',
      'restaurant': 'Pizza Palace',
      'price': 42.0,
      'rating': 4.8,
    },
    {
      'name': 'Pad Thai',
      'restaurant': 'Thai Delight',
      'price': 38.0,
      'rating': 4.7,
    },
    {
      'name': 'Fish & Chips',
      'restaurant': 'Seaside Cafe',
      'price': 45.0,
      'rating': 4.5,
    },
    {
      'name': 'Chicken Wings',
      'restaurant': 'Wings Express',
      'price': 32.0,
      'rating': 4.6,
    },
    {
      'name': 'Caesar Salad',
      'restaurant': 'Green Garden',
      'price': 28.0,
      'rating': 4.4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
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
          loc.popularItems,
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20.w(context)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h(context),
          crossAxisSpacing: 16.w(context),
          childAspectRatio: 0.75,
        ),
        itemCount: _popularItems.length,
        itemBuilder: (context, index) {
          final item = _popularItems[index];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.w(context)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomNetworkImage(
                    imageUrl: AppData.getFoodImage(index),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    borderRadiusGeometry: BorderRadius.vertical(
                      top: Radius.circular(16.w(context)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.w(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] as String,
                        style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 14.sp(context),
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h(context)),
                      Text(
                        item['restaurant'] as String,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12.sp(context),
                          color: AppColors.textHint,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${item['price']}',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontSize: 16.sp(context),
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14.w(context),
                                color: AppColors.star,
                              ),
                              SizedBox(width: 4.w(context)),
                              Text(
                                '${item['rating']}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 12.sp(context),
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
