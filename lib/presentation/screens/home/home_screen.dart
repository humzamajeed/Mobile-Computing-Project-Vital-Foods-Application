import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/core/storage/shared_preferences_service.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Home Screen - Main app screen with categories and restaurants
/// Design: Figma node-id=218-2465
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Show offers popup only once after login
    _checkAndShowOffers();
  }

  Future<void> _checkAndShowOffers() async {
    final hasShownOffers = SharedPreferencesService.getOfferPageShown();
    if (!hasShownOffers) {
      // Show offers popup after 6 seconds
      Future.delayed(const Duration(seconds: 6), () {
        if (mounted) {
          Navigator.pushNamed(context, '/offers').then((_) {
            // Mark as shown after user closes the offer page
            SharedPreferencesService.setOfferPageShown(true);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Container(
              height: 109.h(context),
              color: AppColors.white,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                  child: Row(
                    children: [
                      // Menu button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Container(
                          width: 45.w(context),
                          height: 45.w(context),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(14.w(context)),
                          ),
                          child: Icon(
                            Icons.menu,
                            size: 24.w(context),
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),

                      SizedBox(width: 18.w(context)),

                      // Deliver To section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  loc.deliverTo,
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 12.w(context),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h(context)),
                            Row(
                              children: [
                                Text(
                                  'Halal Lab office',
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 14.w(context),
                                    color: AppColors.mutedGrayDark,
                                  ),
                                ),
                                SizedBox(width: 8.w(context)),
                                Transform.rotate(
                                  angle: 3.14159, // 180 degrees
                                  child: Icon(
                                    Icons.arrow_drop_up,
                                    size: 16.w(context),
                                    color: AppColors.mutedGrayDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Cart button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Container(
                          width: 45.w(context),
                          height: 45.w(context),
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: 22.w(context),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Greeting
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 16.w(context),
                    height: 26 / 16,
                    color: AppColors.textPrimary,
                  ),
                  children: [
                    TextSpan(text: loc.heyName('Halal')),
                    TextSpan(
                      text: ' ${loc.goodAfternoon}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 18.h(context)),

            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  height: 62.h(context),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceF6,
                    borderRadius: BorderRadius.circular(10.w(context)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 20.w(context),
                        color: AppColors.mutedGrayDark,
                      ),
                      SizedBox(width: 12.w(context)),
                      Text(
                        loc.searchDishesRestaurants,
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.w(context),
                          color: AppColors.mutedGrayDark,
                          letterSpacing: -0.33,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h(context)),

            // All Categories section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.allCategories,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 20.w(context),
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/food-category');
                    },
                    child: Row(
                      children: [
                        Text(
                          loc.seeAll,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            color: AppColors.textPrimary,
                            letterSpacing: -0.33,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12.w(context),
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h(context)),

            // Category cards
            SizedBox(
              height: 172.h(context),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                children: [
                  _buildCategoryCard(context, 'Pizza', '\$70'),
                  SizedBox(width: 14.w(context)),
                  _buildCategoryCard(context, 'Burger', '\$50'),
                  SizedBox(width: 14.w(context)),
                  _buildCategoryCard(context, 'Hot Dog', '\$40'),
                ],
              ),
            ),

            SizedBox(height: 24.h(context)),

            // Open Restaurants section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.openRestaurants,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 20.w(context),
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/food-category');
                    },
                    child: Row(
                      children: [
                        Text(
                          loc.seeAll,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            color: AppColors.textPrimary,
                            letterSpacing: -0.33,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12.w(context),
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h(context)),

            // Restaurant cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: Column(
                children: [
                  _buildRestaurantCard(
                    context,
                    name: 'Rose Garden Restaurant',
                    index: 0,
                    imageUrl: AppData.restaurantImages[0],
                  ),
                  SizedBox(height: 24.h(context)),
                  _buildRestaurantCard(
                    context,
                    name: 'Cafenio Restaurant',
                    index: 1,
                    imageUrl: AppData.restaurantImages[1],
                  ),
                  SizedBox(height: 40.h(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String name, String price) {
    final loc = AppLocalizations.of(context)!;
    // Extract numeric price for food details
    final priceValue = int.tryParse(price.replaceAll('\$', '')) ?? 50;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/food-details',
          arguments: {
            'foodName': name,
            'restaurantName': 'Rose Garden Restaurant',
            'price': priceValue,
          },
        );
      },
      child: Container(
        width: 147.w(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.w(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            CustomNetworkImage(
              imageUrl: AppData.getFoodImage(
                name.length,
              ), // Deterministic random
              height: 104.h(context),
              width: double.infinity,
              fit: BoxFit.cover,
              borderRadiusGeometry: BorderRadius.only(
                topLeft: Radius.circular(15.w(context)),
                topRight: Radius.circular(15.w(context)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(9.w(context)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 15.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          loc.starting,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 11.w(context),
                            color: AppColors.mutedGrayDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 13.w(context),
                          color: AppColors.textPrimary,
                          letterSpacing: -0.33,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(
    BuildContext context, {
    required String name,
    int index = 0,
    String? imageUrl,
  }) {
    final loc = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/restaurant-view',
          arguments: {
            'restaurantName': name,
            'rating': 4.7,
            'imageUrl':
                imageUrl ??
                AppData.restaurantImages[index %
                    AppData.restaurantImages.length],
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant image
          CustomNetworkImage(
            imageUrl:
                imageUrl ??
                AppData.restaurantImages[index %
                    AppData.restaurantImages.length],
            height: 137.h(context),
            width: double.infinity,
            borderRadius: 15.w(context),
            fit: BoxFit.cover,
          ),

          SizedBox(height: 12.h(context)),

          // Restaurant name
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 20.w(context),
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 4.h(context)),

          // Cuisine type
          Text(
            loc.cuisineTypes,
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.w(context),
              color: AppColors.textHint,
            ),
          ),

          SizedBox(height: 8.h(context)),

          // Rating, delivery, time
          Row(
            children: [
              // Rating
              Icon(Icons.star, size: 20.w(context), color: AppColors.primary),
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

              SizedBox(width: 24.w(context)),

              // Delivery
              Icon(
                Icons.delivery_dining,
                size: 20.w(context),
                color: AppColors.primary,
              ),
              SizedBox(width: 4.w(context)),
              Text(
                'Free',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 14.w(context),
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(width: 24.w(context)),

              // Time
              Icon(
                Icons.access_time,
                size: 20.w(context),
                color: AppColors.primary,
              ),
              SizedBox(width: 4.w(context)),
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
    );
  }
}
