import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Search Screen - Search for dishes and restaurants
/// Design: Figma node-id=38-1186
/// Exact Dimensions from Figma:
/// - Screen: 375x812px
/// - Top bar: at y=50px with back button and cart
/// - Search input: 327x62px at (24, 123)
/// - Recent Keywords: chips at y=245
/// - Suggested Restaurants: list starting at y=367
/// - Popular Fast food: cards at y=670
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController(
    text: 'Pizza',
  );
  final List<String> _recentKeywords = ['Burger', 'Pizza', 'Sandwich', 'Taco'];
  
  String _searchQuery = '';
  bool _showSuggestions = false;

  final List<Map<String, dynamic>> _suggestedRestaurants = [
    {'name': 'Pansi Restaurant', 'rating': 4.7},
    {'name': 'American Spicy Burger Shop', 'rating': 4.3},
    {'name': 'Cafenio Coffee Club', 'rating': 4.0},
  ];

  final List<Map<String, String>> _popularFastFood = [
    {'name': 'European Pizza', 'restaurant': 'Uttora Coffe House'},
    {'name': 'Buffalo Pizza.', 'restaurant': 'Cafenio Coffee Club'},
  ];

  @override
  void initState() {
    super.initState();
    _searchQuery = _searchController.text;
    _showSuggestions = false; // Don't show suggestions on initial load
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _showSuggestions = _searchQuery.isNotEmpty;
    });
  }

  List<String> _getAllSearchableItems() {
    // Static list of common food items
    final commonFoodItems = [
      'Pizza',
      'Burger',
      'Sandwich',
      'Taco',
      'Pasta',
      'Salad',
      'Sushi',
      'Wings',
      'Steak',
      'Chicken',
      'Fish',
      'Soup',
      'Dessert',
      'Coffee',
      'Ice Cream',
    ];

    // Extract restaurant names from suggested restaurants
    final restaurantNames = _suggestedRestaurants
        .map((restaurant) => restaurant['name'] as String)
        .toList();

    // Extract food names from popular fast food
    final foodNames = _popularFastFood
        .map((food) => food['name'] as String)
        .toList();

    // Combine all sources
    final allItems = <String>[];
    allItems.addAll(commonFoodItems);
    allItems.addAll(restaurantNames);
    allItems.addAll(foodNames);

    // Remove duplicates and return
    return allItems.toSet().toList();
  }

  List<String> _getSuggestions() {
    if (_searchQuery.isEmpty) {
      return [];
    }

    final query = _searchQuery.toLowerCase();
    final allItems = _getAllSearchableItems();

    // Filter suggestions based on partial text match (case-insensitive)
    final suggestions = allItems
        .where((item) => item.toLowerCase().contains(query))
        .toList();

    // Limit suggestions to 10 items
    return suggestions.take(10).toList();
  }

  List<Widget> _buildSuggestionsOverlayList(BuildContext context) {
    if (!_showSuggestions) {
      return [];
    }

    final suggestions = _getSuggestions();
    if (suggestions.isEmpty) {
      return [];
    }

    // Calculate scaled dimensions (same as in build method)
    const searchBarLeft = 24.0;
    const searchBarTop = 123.0;
    const searchBarWidth = 327.0;
    const searchBarHeight = 62.0;

    final scaledSearchBarLeft = searchBarLeft.w(context);
    final scaledSearchBarTop = searchBarTop.h(context);
    final scaledSearchBarWidth = searchBarWidth.w(context);
    final scaledSearchBarHeight = searchBarHeight.h(context);

    // Calculate position below search bar
    final searchBarBottom = scaledSearchBarTop + scaledSearchBarHeight;
    const overlayPadding = 8.0;
    const maxHeight = 200.0;

    return [
      Positioned(
        left: scaledSearchBarLeft,
        top: searchBarBottom + overlayPadding.h(context),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10.w(context)),
          color: Colors.transparent,
          child: Container(
            width: scaledSearchBarWidth,
            constraints: BoxConstraints(
              maxHeight: maxHeight.h(context),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w(context)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    _searchController.text = suggestion;
                    _searchQuery = suggestion;
                    _showSuggestions = false;
                  });
                  // Remove focus from text field
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w(context),
                    vertical: 14.h(context),
                  ),
                  decoration: BoxDecoration(
                    border: index < suggestions.length - 1
                        ? Border(
                            bottom: BorderSide(
                              color: AppColors.handleGray.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 18.w(context),
                        color: AppColors.mutedGrayMid,
                      ),
                      SizedBox(width: 12.w(context)),
                      Expanded(
                        child: Text(
                          suggestion,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.w(context),
                            color: AppColors.textPrimaryDeep,
                            letterSpacing: -0.33,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Get actual screen size

    // Exact dimensions from Figma
    const cartRight = 24.0;
    const cartSize = 45.0;
    const filterRight = 79.0; // Position filter button to the left of cart

    const searchBarLeft = 24.0;
    const searchBarTop = 123.0;
    const searchBarWidth = 327.0;
    const searchBarHeight = 62.0;

    // Scale to current device
    final scaledBackButtonLeft = 24.w(context);
    final scaledTopBarTop = 50.h(context);
    final scaledBackButtonSize = 45.w(context);
    final scaledCartSize = cartSize.w(context);
    final scaledFilterSize = 45.w(context);

    final scaledSearchBarLeft = searchBarLeft.w(context);
    final scaledSearchBarTop = searchBarTop.h(context);
    final scaledSearchBarWidth = searchBarWidth.w(context);
    final scaledSearchBarHeight = searchBarHeight.h(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200.h(context)), // Space for fixed header
                  // Recent Keywords Section
                  Padding(
                    padding: EdgeInsets.only(
                      left: scaledBackButtonLeft,
                      top: 9.h(context),
                    ),
                    child: Text(
                      loc.recentKeywords,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),

                  SizedBox(height: 36.h(context)),

                  // Keywords chips
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaledBackButtonLeft,
                    ),
                    child: Wrap(
                      spacing: 10.w(context),
                      runSpacing: 10.h(context),
                      children: _recentKeywords.map((keyword) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to food category screen
                            Navigator.pushNamed(
                              context,
                              '/food-category',
                              arguments: {'category': keyword},
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w(context),
                              vertical: 14.h(context),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceF6,
                              borderRadius: BorderRadius.circular(
                                33.w(context),
                              ),
                            ),
                            child: Text(
                              keyword,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 16.w(context),
                                color: AppColors.textPrimaryDeep,
                                letterSpacing: -0.33,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 32.h(context)),

                  // Suggested Restaurants Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaledBackButtonLeft,
                    ),
                    child: Text(
                      loc.suggestedRestaurants,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),

                  SizedBox(height: 44.h(context)),

                  // Restaurant items
                  ...List.generate(_suggestedRestaurants.length, (index) {
                    final restaurant = _suggestedRestaurants[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/restaurant-view',
                          arguments: {
                            'restaurantName': restaurant['name'],
                            'rating': restaurant['rating'],
                            'imageUrl':
                                AppData.restaurantImages[index %
                                    AppData.restaurantImages.length],
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: scaledBackButtonLeft,
                          right: scaledBackButtonLeft,
                          bottom: 32.h(context),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Restaurant image placeholder
                                CustomNetworkImage(
                                  imageUrl:
                                      AppData.restaurantImages[index %
                                          AppData.restaurantImages.length],
                                  width: 60.w(context),
                                  height: 50.h(context),
                                  borderRadius: 10.w(context),
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10.w(context)),
                                // Restaurant details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurant['name'],
                                        style: TextStyle(
                                          fontFamily: 'Sen',
                                          fontSize: 16.w(context),
                                          color: AppColors.textDark,
                                          letterSpacing: -0.33,
                                        ),
                                      ),
                                      SizedBox(height: 4.h(context)),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 15.w(context),
                                            color: AppColors.star,
                                          ),
                                          SizedBox(width: 4.w(context)),
                                          Text(
                                            restaurant['rating'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Sen',
                                              fontSize: 16.w(context),
                                              color: AppColors.textPrimaryDeep,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Divider line
                            if (index < _suggestedRestaurants.length - 1)
                              Container(
                                margin: EdgeInsets.only(top: 14.h(context)),
                                height: 1.h(context),
                                color: AppColors.handleGray,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 32.h(context)),

                  // Popular Fast food Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaledBackButtonLeft,
                    ),
                    child: Text(
                      loc.popularFastFood,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20.w(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimaryDeep,
                      ),
                    ),
                  ),

                  SizedBox(height: 51.h(context)),

                  // Fast food cards
                  SizedBox(
                    height: 144.h(context),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: scaledBackButtonLeft,
                      ),
                      itemCount: _popularFastFood.length,
                      itemBuilder: (context, index) {
                        final food = _popularFastFood[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/food-details',
                              arguments: {
                                'foodName': food['name'],
                                'restaurantName': food['restaurant'],
                                'price': 32,
                                'imageUrl': AppData.getFoodImage(index),
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 24.w(context)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Food image
                                CustomNetworkImage(
                                  imageUrl: AppData.getFoodImage(index),
                                  width: 122.w(context),
                                  height: 84.h(context),
                                  borderRadius: 15.w(context),
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 6.h(context)),
                                // Food name
                                SizedBox(
                                  width: 122.w(context),
                                  child: Text(
                                    food['name']!,
                                    style: TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 15.w(context),
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textDark,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h(context)),
                                // Restaurant name
                                SizedBox(
                                  width: 122.w(context),
                                  child: Text(
                                    food['restaurant']!,
                                    style: TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 13.w(context),
                                      color: AppColors.mutedGrayDarker,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 100.h(context)), // Bottom padding
                ],
              ),
            ),
          ),

          // Fixed header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 195.h(context),
              color: Colors.white,
              child: Stack(
                children: [
                  // Back button
                  Positioned(
                    left: scaledBackButtonLeft,
                    top: scaledTopBarTop + 4.h(context),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: scaledBackButtonSize,
                        height: scaledBackButtonSize,
                        decoration: BoxDecoration(
                          color: AppColors.neutralECF0,
                          borderRadius: BorderRadius.circular(14.w(context)),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.w(context),
                          color: AppColors.textPrimaryDeep,
                        ),
                      ),
                    ),
                  ),

                  // "Search" title
                  Positioned(
                    left: 85.w(context),
                    top: 66.h(context),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 17.w(context),
                        color: AppColors.textPrimaryDeep,
                        height: 22 / 17,
                      ),
                    ),
                  ),

                  // Filter button
                  Positioned(
                    right: filterRight.w(context),
                    top: scaledTopBarTop + 4.h(context),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/filter');
                      },
                      child: Container(
                        width: scaledFilterSize,
                        height: scaledFilterSize,
                        decoration: const BoxDecoration(
                          color: AppColors.neutralECF0,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.tune,
                          size: 20.w(context),
                          color: AppColors.textPrimaryDeep,
                        ),
                      ),
                    ),
                  ),

                  // Cart button
                  Positioned(
                    right: cartRight.w(context),
                    top: scaledTopBarTop + 4.h(context),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Container(
                        width: scaledCartSize,
                        height: scaledCartSize,
                        decoration: const BoxDecoration(
                          color: AppColors.textPrimaryDeep,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 22.w(context),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Search input
                  Positioned(
                    left: scaledSearchBarLeft,
                    top: scaledSearchBarTop,
                    child: Container(
                      width: scaledSearchBarWidth,
                      height: scaledSearchBarHeight,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceF6,
                        borderRadius: BorderRadius.circular(10.w(context)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20.w(context)),
                          Icon(
                            Icons.search,
                            size: 20.w(context),
                            color: AppColors.mutedGrayMid,
                          ),
                          SizedBox(width: 12.w(context)),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.textPrimaryDeep,
                                letterSpacing: -0.33,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search dishes, restaurants',
                                hintStyle: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 14.w(context),
                                  color: AppColors.mutedGrayLight,
                                  letterSpacing: -0.33,
                                ),
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                  _showSuggestions = false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15.w(context)),
                                child: Icon(
                                  Icons.close,
                                  size: 20.w(context),
                                  color: AppColors.mutedGrayLight,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          // Search suggestions overlay (outside header container to avoid clipping)
          ..._buildSuggestionsOverlayList(context),
        ],
      ),
    );
  }
}
