import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/size_extensions.dart';
import '../../../core/data/app_data.dart';
import '../../../core/utils/app_routes.dart';
import '../../../presentation/widgets/custom_network_image.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/favorite_provider.dart';

/// Favorites Screen
/// Design: Figma node-id=149:1163
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(loc.favorites),
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: const [
              Tab(text: 'Restaurants'),
              Tab(text: 'Food Items'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(children: [_RestaurantsList(), _FoodItemsList()]),
        ),
      ),
    );
  }
}

class _RestaurantsList extends StatelessWidget {
  final List<Map<String, dynamic>> _mockRestaurants = [
    {
      'name': 'Rose Garden Restaurant',
      'cuisine': 'Burger - Chicken - Rice - Wings',
      'rating': 4.7,
      'delivery': 'Free',
      'time': '20 min',
      'imageIndex': 0,
    },
    {
      'name': 'Cafenio Restaurant',
      'cuisine': 'Pizza - Pasta - Italian',
      'rating': 4.5,
      'delivery': 'Free',
      'time': '25 min',
      'imageIndex': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(24.w(context)),
      itemCount: _mockRestaurants.length,
      itemBuilder: (context, index) {
        final restaurant = _mockRestaurants[index];
        return _RestaurantCard(restaurant: restaurant);
      },
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const _RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/restaurant-view');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant image
            CustomNetworkImage(
              imageUrl:
                  AppData.restaurantImages[restaurant['imageIndex'] %
                      AppData.restaurantImages.length],
              height: 137.h(context),
              width: double.infinity,
              borderRadius: 15.w(context),
              fit: BoxFit.cover,
            ),

            SizedBox(height: 12.h(context)),

            // Restaurant name
            Text(
              restaurant['name'],
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 20.w(context),
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 4.h(context)),

            // Cuisine type
            Text(
              restaurant['cuisine'],
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
                  restaurant['rating'].toString(),
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
                  restaurant['delivery'],
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
                  restaurant['time'],
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

class _FoodItemsList extends StatefulWidget {
  const _FoodItemsList();

  @override
  State<_FoodItemsList> createState() => _FoodItemsListState();
}

class _FoodItemsListState extends State<_FoodItemsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFavorites();
    });
  }

  void _loadFavorites() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    if (authProvider.user != null) {
      favoriteProvider.loadFavorites(authProvider.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FavoriteProvider>(
      builder: (context, authProvider, favoriteProvider, _) {
        if (authProvider.user == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w(context)),
              child: Text(
                'Please login to view favorites',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.sp(context),
                  color: AppColors.textHint,
                ),
              ),
            ),
          );
        }

        if (favoriteProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          );
        }

        if (favoriteProvider.favorites.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w(context)),
              child: Text(
                'No favorites yet',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.sp(context),
                  color: AppColors.textHint,
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(24.w(context)),
          itemCount: favoriteProvider.favorites.length,
          itemBuilder: (context, index) {
            final favorite = favoriteProvider.favorites[index];
            return _FoodCard(favorite: favorite);
          },
        );
      },
    );
  }
}

class _FoodCard extends StatelessWidget {
  final dynamic favorite; // FavoriteItem

  const _FoodCard({required this.favorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.foodDetails,
          arguments: {
            'foodName': favorite.foodName,
            'restaurantName': favorite.restaurantName,
            'price': favorite.price,
            'imageUrl': favorite.imageUrl,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image
            CustomNetworkImage(
              imageUrl: favorite.imageUrl,
              width: 104.w(context),
              height: 104.w(context),
              borderRadius: 15.w(context),
              fit: BoxFit.cover,
            ),

            SizedBox(width: 16.w(context)),

            // Food details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food name
                  Text(
                    favorite.foodName,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 16.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 4.h(context)),

                  // Restaurant name
                  Text(
                    favorite.restaurantName ?? 'Restaurant',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 14.w(context),
                      color: AppColors.textHint,
                    ),
                  ),

                  SizedBox(height: 8.h(context)),

                  // Price
                  Text(
                    '\$${favorite.price}',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 18.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Favorite icon
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: AppColors.primary,
                size: 24.w(context),
              ),
              onPressed: () {
                // Favorite toggle (UI only)
              },
            ),
          ],
        ),
      ),
    );
  }
}
