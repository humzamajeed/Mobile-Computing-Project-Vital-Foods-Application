import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/presentation/providers/cart_provider.dart';
import 'package:finalproject/presentation/providers/favorite_provider.dart';
import 'package:finalproject/domain/entities/cart_item.dart';

/// Food Details Screen - Shows detailed information about a food item
/// Design: Figma node-id=212-175
/// Exact Dimensions from Figma:
/// - Screen: 375x876px (taller than standard)
/// - Hero image: 375x321px
/// - Size selector at y=550
/// - Ingredients at y=618
/// - Bottom cart section: 375x184px at y=692
class FoodDetailsScreen extends StatefulWidget {
  final String? foodName;
  final String? restaurantName;
  final int? price;
  final String? imageUrl;

  const FoodDetailsScreen({
    super.key,
    this.foodName,
    this.restaurantName,
    this.price,
    this.imageUrl,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 1;
  String _selectedSize = '14"';
  bool _isFavorite = false;
  bool _isLoadingFavorite = false;

  final List<String> _sizes = ['10"', '14"', '16"'];
  final List<Map<String, String>> _ingredients = [
    {'name': 'Salt', 'icon': '🧂'},
    {'name': 'Chicken', 'icon': '🍗'},
    {'name': 'onion\n(Alergy)', 'icon': '🧅'},
    {'name': 'Garlic', 'icon': '🧄'},
    {'name': 'Pappers\n(Alergy)', 'icon': '🌶️'},
    {'name': 'Ginger', 'icon': '🫚'},
    {'name': 'Broccoli', 'icon': '🥦'},
    {'name': 'Orange', 'icon': '🍊'},
    {'name': 'Walnut', 'icon': '🌰'},
  ];

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    // Check if user is authenticated
    if (!authProvider.isAuthenticated || widget.foodName == null) {
      return;
    }

    final user = authProvider.user;
    if (user != null) {
      final isFav = await favoriteProvider.checkFavorite(
        userId: user.id,
        foodName: widget.foodName!,
      );
      if (mounted) {
        setState(() {
          _isFavorite = isFav;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    // Check if user is authenticated
    if (!authProvider.isAuthenticated || widget.foodName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.pleaseLoginToAddFavorites,
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final user = authProvider.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.pleaseLoginToAddFavorites,
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoadingFavorite = true;
    });

    final success = await favoriteProvider.toggleFavorite(
      userId: user.id,
      foodName: widget.foodName!,
      restaurantName: widget.restaurantName,
      price: widget.price ?? 50,
      imageUrl:
          widget.imageUrl ?? AppData.getFoodImage(widget.foodName!.length),
    );

    if (mounted) {
      setState(() {
        _isLoadingFavorite = false;
        if (success) {
          _isFavorite = !_isFavorite;
        }
      });

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              favoriteProvider.errorMessage ?? 'Failed to update favorite',
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    // Get actual screen size

    // Scale to current device
    // 346.h(context) removed - use heroImageHeight.h(context) directly
    // 50.w(context) removed - use 50.h(context) directly
    // 24.w(context) removed - use 24.w(context) directly
    // 45.w(context) removed - use 45.w(context) directly

    // 184.h(context) removed - use cartSectionHeight.h(context) directly

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
                  CustomNetworkImage(
                    imageUrl:
                        widget.imageUrl ??
                        AppData.getFoodImage(widget.foodName?.length ?? 5),
                    width: context.screenWidth,
                    height: 346.h(context),
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 24.h(context)),

                  // Food Name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Text(
                      widget.foodName ?? 'Burger Bistro',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  SizedBox(height: 7.h(context)),

                  // Restaurant info
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppData.restaurantImages[0],
                          width: 22.w(context),
                          height: 22.h(context),
                          borderRadius: 22.w(context), // Circle
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 9.w(context)),
                        Text(
                          widget.restaurantName ?? 'Rose Garden',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.w(context),
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h(context)),

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
                        SizedBox(width: 6.w(context)),
                        Text(
                          '4.7',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 16.w(context),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 35.w(context)),
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
                        SizedBox(width: 34.w(context)),
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
                  ),

                  SizedBox(height: 20.h(context)),

                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: SizedBox(
                      width: 323.w(context),
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

                  SizedBox(height: 20.h(context)),

                  // Size selector
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Row(
                      children: [
                        Text(
                          '${loc.size.toUpperCase()}:',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.w(context),
                            color: AppColors.textHint,
                            height: 24 / 14,
                          ),
                        ),
                        SizedBox(width: 27.w(context)),
                        ...List.generate(_sizes.length, (index) {
                          final size = _sizes[index];
                          final isSelected = _selectedSize == size;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedSize = size;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w(context)),
                              width: 48.w(context),
                              height: 48.h(context),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryLight
                                    : AppColors.backgroundGrey,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 16.w(context),
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h(context)),

                  // Ingredients section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.ingredients.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 13.w(context),
                            color: AppColors.textPrimary,
                            letterSpacing: 0.26,
                          ),
                        ),
                        SizedBox(height: 16.h(context)),
                        Wrap(
                          spacing: 19.w(context),
                          runSpacing: 19.h(context),
                          children: _ingredients.take(5).map((ingredient) {
                            return Column(
                              children: [
                                Container(
                                  width: 50.w(context),
                                  height: 50.h(context),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      ingredient['icon']!,
                                      style: TextStyle(fontSize: 24.w(context)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h(context)),
                                SizedBox(
                                  width: 50.w(context),
                                  child: Text(
                                    ingredient['name']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.w(context),
                                      color: AppColors.mutedGrayDark,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 19.h(context)),
                        Wrap(
                          spacing: 19.w(context),
                          runSpacing: 19.h(context),
                          children: _ingredients.skip(5).take(4).map((
                            ingredient,
                          ) {
                            return Column(
                              children: [
                                Container(
                                  width: 50.w(context),
                                  height: 50.h(context),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      ingredient['icon']!,
                                      style: TextStyle(fontSize: 24.w(context)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h(context)),
                                SizedBox(
                                  width: 50.w(context),
                                  child: Text(
                                    ingredient['name']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.w(context),
                                      color: AppColors.mutedGrayDark,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 184.h(context) + 20.h(context),
                  ), // Space for bottom cart
                ],
              ),
            ),
          ),

          // Fixed top bar (Back and Save buttons)
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
                  color: Colors.white,
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
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          // Save/Favorite button
          Positioned(
            right: 24.w(context),
            top: 50.w(context),
            child: GestureDetector(
              onTap: _isLoadingFavorite ? null : _toggleFavorite,
              child: Container(
                width: 45.w(context),
                height: 45.w(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: _isLoadingFavorite
                    ? SizedBox(
                        width: 20.w(context),
                        height: 20.w(context),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      )
                    : Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 22.w(context),
                        color: _isFavorite
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
              ),
            ),
          ),

          // Bottom cart section
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 184.h(context),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.w(context)),
                  topRight: Radius.circular(24.w(context)),
                ),
              ),
              child: Stack(
                children: [
                  // Price
                  Positioned(
                    left: 24.w(context),
                    top: 27.h(context),
                    child: Text(
                      '\$${widget.price ?? 32}',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 28.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // Quantity selector
                  Positioned(
                    right: 24.w(context),
                    top: 20.h(context),
                    child: Container(
                      width: 125.w(context),
                      height: 48.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(50.w(context)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_quantity > 1) {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              size: 24.w(context),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _quantity.toString(),
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 16.w(context),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 24.w(context),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Add to Cart button
                  Consumer2<AuthProvider, CartProvider>(
                    builder: (context, authProvider, cartProvider, _) {
                      return Positioned(
                        left: 24.w(context),
                        bottom: 38.h(context),
                        child: SizedBox(
                          width: 327.w(context),
                          height: 62.h(context),
                          child: ElevatedButton(
                            onPressed: cartProvider.isLoading
                                ? null
                                : () async {
                                    if (!authProvider.isAuthenticated) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            loc.pleaseLoginToAddFavorites,
                                          ),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                      return;
                                    }

                                    final user = authProvider.user;
                                    if (user == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            loc.pleaseLoginToAddFavorites,
                                          ),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                      return;
                                    }

                                    // Create cart item
                                    // Generate ID based on food name, size, and price so same items merge
                                    final foodName =
                                        widget.foodName ?? 'Burger Bistro';
                                    final price = (widget.price ?? 32)
                                        .toDouble();
                                    final itemId =
                                        '${foodName}_${_selectedSize}_${price.toStringAsFixed(0)}';

                                    final cartItem = CartItem(
                                      id: itemId,
                                      foodName: foodName,
                                      restaurantName:
                                          widget.restaurantName ??
                                          'Rose Garden',
                                      price: price,
                                      quantity: _quantity,
                                      imageUrl: AppData.getFoodImage(
                                        (widget.foodName?.length ?? 5) % 10,
                                      ),
                                      size: _selectedSize,
                                      createdAt: DateTime.now(),
                                    );

                                    // Add to cart
                                    final success = await cartProvider
                                        .addToCart(
                                          userId: user.id,
                                          item: cartItem,
                                        );

                                    if (success && context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(loc.itemAddedToCart),
                                          backgroundColor:
                                              AppColors.successDark,
                                        ),
                                      );
                                      // Optionally navigate to cart
                                      // Navigator.pushNamed(context, '/cart');
                                    } else if (!success && context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            cartProvider.errorMessage ??
                                                'Failed to add item to cart',
                                          ),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              disabledBackgroundColor: AppColors.textSecondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.w(context),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: cartProvider.isLoading
                                ? SizedBox(
                                    width: 20.w(context),
                                    height: 20.w(context),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    loc.addToCart.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 16.w(context),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
