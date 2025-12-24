import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Restaurant View Screen - Shows restaurant details and menu items
/// Design: Figma node-id=212-241
/// Exact Dimensions from Figma:
/// - Screen: 375x1018px (tall screen)
/// - Hero image: 375x321px with carousel indicators
/// - Category tabs at y=515
/// - Food items grid starting at y=633
class RestaurantViewScreen extends StatefulWidget {
  final String? restaurantName;
  final double? rating;
  final String? imageUrl;

  const RestaurantViewScreen({
    super.key,
    this.restaurantName,
    this.rating,
    this.imageUrl,
  });

  @override
  State<RestaurantViewScreen> createState() => _RestaurantViewScreenState();
}

class _RestaurantViewScreenState extends State<RestaurantViewScreen> {
  String _selectedCategory = '';
  List<String> _categories = [];

  final List<Map<String, dynamic>> _foodItems = [
    {'name': 'Burger Ferguson', 'description': 'Spicy restaurant', 'price': 40},
    {'name': "Rockin' Burgers", 'description': 'Cafecafachino', 'price': 40},
    {'name': 'Meat Pizza', 'description': 'Spicy burger', 'price': 40},
    {'name': 'Spicy Tacos', 'description': 'Mexican special', 'price': 35},
  ];

  @override
  void initState() {
    super.initState();
    // Categories will be initialized in build method to access localization
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Initialize categories with localized strings
    if (_categories.isEmpty) {
      _categories = [loc.burger, loc.sandwich, loc.pizza, loc.taco];
      _selectedCategory = _categories[0];
    }

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
                  // Hero Image
                  Stack(
                    children: [
                      CustomNetworkImage(
                        imageUrl:
                            widget.imageUrl ?? AppData.restaurantImages[0],
                        width: context.screenWidth,
                        height: 346.h(context),
                        fit: BoxFit.cover,
                        borderRadiusGeometry: BorderRadius.only(
                          bottomLeft: Radius.circular(24.w(context)),
                          bottomRight: Radius.circular(24.w(context)),
                        ),
                      ),
                      // Carousel indicators
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 293.h(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 4.w(context),
                              ),
                              width: index == 2 ? 20.w(context) : 8.w(context),
                              height: 8.h(context),
                              decoration: BoxDecoration(
                                color: index == 2
                                    ? AppColors.white
                                    : AppColors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(
                                  4.w(context),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 25.h(context)),

                  // Rating, Delivery, Time
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20.w(context),
                          color: AppColors.star,
                        ),
                        SizedBox(width: 10.w(context)),
                        Text(
                          widget.rating?.toString() ?? '4.7',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryDeep,
                          ),
                        ),
                        SizedBox(width: 35.w(context)),
                        Icon(
                          Icons.delivery_dining,
                          size: 20.w(context),
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 10.w(context)),
                        Text(
                          loc.free,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.w(context),
                            color: AppColors.textPrimaryDeep,
                          ),
                        ),
                        SizedBox(width: 42.w(context)),
                        Icon(
                          Icons.access_time,
                          size: 20.w(context),
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 10.w(context)),
                        Text(
                          '20 ${loc.minutes}',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.w(context),
                            color: AppColors.textPrimaryDeep,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h(context)),

                  // Restaurant name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Text(
                      widget.restaurantName ?? 'Spicy restaurant',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryDeep,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h(context)),

                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: SizedBox(
                      width: 324.w(context),
                      child: Text(
                        'Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.w(context),
                          color: AppColors.textHint,
                          height: 24 / 14,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 33.h(context)),

                  // Category tabs
                  SizedBox(
                    height: 46.h(context),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w(context)),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w(context),
                              vertical: 10.h(context),
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.surfaceF6,
                              borderRadius: BorderRadius.circular(
                                33.w(context),
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 16.w(context),
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textPrimaryDeep,
                                letterSpacing: -0.33,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 32.h(context)),

                  // Section title "Burger (10)"
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Text(
                      '$_selectedCategory (10)',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimaryDeep,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
                  ),

                  SizedBox(height: 12.h(context)),

                  // Food items grid
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 21.w(context),
                        mainAxisSpacing: 20.h(context),
                        childAspectRatio: (153.w(context)) / (174.h(context)),
                      ),
                      itemCount: _foodItems.length,
                      itemBuilder: (context, index) {
                        final item = _foodItems[index];
                        return _buildFoodItem(context, item, index);
                      },
                    ),
                  ),

                  SizedBox(height: 40.h(context)), // Bottom padding
                ],
              ),
            ),
          ),

          // Fixed top bar (Back and More buttons)
          Positioned(
            left: 24.w(context),
            top: 50.w(context),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45.w(context),
                height: 45.w(context),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.w(context),
                  color: AppColors.textPrimaryDeep,
                ),
              ),
            ),
          ),

          // More button
          Positioned(
            right: 24.w(context),
            top: 50.w(context),
            child: Container(
              width: 45.w(context),
              height: 45.w(context),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.more_horiz,
                size: 24.w(context),
                color: AppColors.textPrimaryDeep,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(
    BuildContext context,
    Map<String, dynamic> item,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/food-details',
          arguments: {
            'foodName': item['name'],
            'restaurantName': item['description'],
            'price': item['price'],
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food image
          CustomNetworkImage(
            imageUrl: AppData.getFoodImage(index + 5),
            height: 75.h(context),
            borderRadius: 15.w(context),
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 6.h(context)),

          // Food name
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              item['name'],
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 13.w(context),
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
                letterSpacing: -0.33,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(height: 2.h(context)),

          // Description
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              item['description'],
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 11.w(context),
                color: AppColors.mutedGrayDarker,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(height: 6.h(context)),

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
                  color: AppColors.textPrimaryDeep,
                  letterSpacing: -0.33,
                ),
              ),
              Container(
                width: 28.w(context),
                height: 28.h(context),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 16.w(context),
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
