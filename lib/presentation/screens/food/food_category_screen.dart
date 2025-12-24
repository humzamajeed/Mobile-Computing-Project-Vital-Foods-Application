import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/l10n/app_localizations.dart';

/// Food Category Screen - Shows food items by category (e.g., Burgers)
/// Design: Figma node-id=38-1080
/// Exact Dimensions from Figma:
/// - Screen: 375x812px
/// - Top bar: at y=50px with back, category selector, search, filter
/// - Product cards: 153x162px in 2-column grid
/// - Restaurant card: 327x140px at bottom
class FoodCategoryScreen extends StatefulWidget {
  final String category;

  const FoodCategoryScreen({super.key, this.category = 'Burger'});

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  final List<Map<String, dynamic>> _popularBurgers = [
    {'name': 'Burger Bistro', 'restaurant': 'Rose garden', 'price': 40},
    {'name': "Smokin' Burger", 'restaurant': 'Cafenio Restaurant', 'price': 60},
    {'name': 'Buffalo Burgers', 'restaurant': 'Kaji Firm Kitchen', 'price': 75},
    {'name': 'Bullseye Burgers', 'restaurant': 'Kabab restaurant', 'price': 94},
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    // Get actual screen size

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Scrollable content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 106.h(context)), // Space for fixed header
                  // "Popular Burgers" title
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w(context),
                      top: 14.h(context),
                    ),
                    child: Text(
                      loc.popularCategory(widget.category),
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h(context)),

                  // Product Grid (2 columns)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 21.w(context),
                        mainAxisSpacing: 20.h(context),
                        childAspectRatio: 153.w(context) / 141.w(context),
                      ),
                      itemCount: _popularBurgers.length,
                      itemBuilder: (context, index) {
                        final item = _popularBurgers[index];
                        return _buildProductCard(context, item);
                      },
                    ),
                  ),

                  SizedBox(height: 24.h(context)),

                  // "Open Restaurants" section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Text(
                      loc.openRestaurants,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h(context)),

                  // Restaurant Card
                  _buildRestaurantCard(context),

                  SizedBox(height: 100.h(context)), // Bottom padding
                ],
              ),
            ),
          ),

          // Fixed header
          _buildHeader(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 106.h(context),
        color: AppColors.white,
        child: Stack(
          children: [
            // Back button
            Positioned(
              left: 24,
              top: 50 + 1.h(context),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 45,
                  height: 45,
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
            ),

            // Category selector
            Positioned(
              left: 86.w(context),
              top: 50.h(context) + 1.h(context),
              child: Container(
                width: 102.w(context),
                height: 45.h(context),
                decoration: BoxDecoration(
                  color: AppColors.surfaceF6,
                  borderRadius: BorderRadius.circular(100.w(context)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 12.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 4.w(context)),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16.w(context),
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ),

            // Search button
            Positioned(
              left: 249.w(context),
              top: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  width: 46.w(context),
                  height: 46.w(context),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search,
                    size: 20.w(context),
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            // Filter button
            Positioned(
              left: 305.w(context),
              top: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/filter');
                },
                child: Container(
                  width: 46.w(context),
                  height: 46.w(context),
                  decoration: const BoxDecoration(
                    color: AppColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.tune,
                    size: 20.w(context),
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/food-details',
          arguments: {
            'foodName': item['name'],
            'restaurantName': item['restaurant'],
            'price': item['price'],
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          CustomNetworkImage(
            imageUrl: AppData.getFoodImage(item['name'].length),
            height: 70.h(context),
            borderRadius: 15.w(context),
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          SizedBox(height: 3.h(context)),

          // Product name
          Text(
            item['name'],
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.w(context),
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.33,
              height: 1.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 1.h(context)),

          // Restaurant name
          Text(
            item['restaurant'],
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 12.w(context),
              color: AppColors.mutedGrayDark,
              height: 1.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 3.h(context)),

          // Price and Add button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${item['price']}',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 15.w(context),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.33,
                  height: 1.0,
                ),
              ),
              Container(
                width: 26.w(context),
                height: 26.h(context),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 15.w(context),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/restaurant-view',
          arguments: {'restaurantName': 'Tasty treat Gallery', 'rating': 4.7},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant image
            CustomNetworkImage(
              imageUrl: AppData.restaurantImages[0],
              width: 327.w(context),
              height: 140.h(context),
              borderRadius: 11.w(context),
              fit: BoxFit.cover,
            ),

            SizedBox(height: 14.h(context)),

            // Restaurant name
            Text(
              'Tasty treat Gallery',
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 20.w(context),
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 12.h(context)),

            // Rating, Delivery, Time
            Row(
              children: [
                Icon(Icons.star, size: 20.w(context), color: AppColors.star),
                SizedBox(width: 4.w(context)),
                Text(
                  '4.7',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.w(context),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 31.w(context)),
                Icon(
                  Icons.delivery_dining,
                  size: 20.w(context),
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w(context)),
                Text(
                  'Free',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 14.w(context),
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 33.w(context)),
                Icon(
                  Icons.access_time,
                  size: 20.w(context),
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w(context)),
                Text(
                  '20 min',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 14.w(context),
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
