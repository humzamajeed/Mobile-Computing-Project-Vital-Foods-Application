import 'package:flutter/material.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/splash/splash_screen_two.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/auth/verification_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/location/location_access_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/cart/cart_screen.dart';
import '../../presentation/screens/food/food_details_screen.dart';
import '../../presentation/screens/payment/payment_screen.dart';
import '../../presentation/screens/restaurant/restaurant_view_screen.dart';
import '../../presentation/screens/tracking/order_tracking_screen.dart';
import '../../presentation/screens/notifications/notifications_screen.dart';
import '../../presentation/screens/favorites/favorites_screen.dart';
import '../../presentation/screens/address/address_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/review/review_screen.dart';
import '../../presentation/screens/review/user_reviews_screen.dart';
import '../../presentation/screens/offers/offers_screen.dart';
import '../../presentation/screens/support/support_screen.dart';
import '../../presentation/screens/food/food_category_screen.dart';
import '../../presentation/screens/payment/add_card_screen.dart';
import '../../presentation/screens/filter/filter_screen.dart';
import '../../presentation/screens/payment/payment_success_screen.dart';
import '../../presentation/screens/payment/payment_processing_screen.dart';
import '../../presentation/screens/tracking/tracking_order_1_screen.dart';
import '../../presentation/screens/tracking/tracking_order_2_screen.dart';
import '../../presentation/screens/tracking/delivery_call_screen.dart';
import '../../presentation/screens/tracking/interactive_tracking_screen.dart';
import '../../presentation/screens/tracking/delivery_message_screen.dart';
import '../../presentation/screens/orders/my_orders_screen.dart';
import '../../presentation/screens/profile/personal_info_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/address/add_address_screen.dart';
import '../../presentation/screens/dashboard/seller_dashboard_screen.dart';
import '../../presentation/screens/dashboard/popular_items_screen.dart';
import '../../presentation/screens/dashboard/seller_reviews_screen.dart';
import '../../presentation/screens/dashboard/seller_notifications_screen.dart';
import '../../presentation/screens/dashboard/my_food_list_screen.dart';
import '../../presentation/screens/dashboard/seller_food_details_screen.dart';
import '../../presentation/screens/dashboard/add_new_food_screen.dart';
import '../../presentation/screens/dashboard/seller_profile_screen.dart';
import '../../presentation/screens/dashboard/withdraw_success_screen.dart';
import '../../presentation/screens/dashboard/running_orders_screen.dart';
import '../../presentation/screens/debug/database_debug_screen.dart';

/// App Routes - Centralized route management
class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String splashTwo = '/splash-two';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String home = '/home';
  static const String locationAccess = '/location-access';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String foodDetails = '/food-details';
  static const String myOrders = '/my-orders';
  static const String payment = '/payment';
  static const String restaurantView = '/restaurant-view';
  static const String orderTracking = '/order-tracking';
  static const String notifications = '/notifications';
  static const String favorites = '/favorites';
  static const String address = '/address';
  static const String settings = '/settings';
  static const String review = '/review';
  static const String userReviews = '/user-reviews';
  static const String offers = '/offers';
  static const String support = '/support';
  static const String foodCategory = '/food-category';
  static const String addCard = '/add-card';
  static const String filter = '/filter';
  static const String paymentSuccess = '/payment-success';
  static const String paymentProcessing = '/payment-processing';
  static const String trackingOrder1 = '/tracking-order-1';
  static const String trackingOrder2 = '/tracking-order-2';
  static const String deliveryCall = '/delivery-call';
  static const String interactiveTracking = '/interactive-tracking';
  static const String deliveryMessage = '/delivery-message';
  static const String personalInfo = '/personal-info';
  static const String editProfile = '/edit-profile';
  static const String addAddress = '/add-address';
  static const String sellerDashboard = '/seller-dashboard';
  static const String popularItems = '/popular-items';
  static const String sellerReviews = '/seller-reviews';
  static const String sellerNotifications = '/seller-notifications';
  static const String myFoodList = '/my-food-list';
  static const String sellerFoodDetails = '/seller-food-details';
  static const String addNewFood = '/add-new-food';
  static const String sellerProfile = '/seller-profile';
  static const String withdrawSuccess = '/withdraw-success';
  static const String runningOrders = '/running-orders';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/splash-two':
        return MaterialPageRoute(builder: (_) => const SplashScreenTwo());

      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case '/verification':
        return MaterialPageRoute(builder: (_) => const VerificationScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/location-access':
        return MaterialPageRoute(builder: (_) => const LocationAccessScreen());

      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case '/food-details':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => FoodDetailsScreen(
            foodName: args?['foodName'] as String?,
            restaurantName: args?['restaurantName'] as String?,
            price: args?['price'] as int?,
            imageUrl: args?['imageUrl'] as String?,
          ),
        );

      case '/my-orders':
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());

      case '/payment':
        return MaterialPageRoute(builder: (_) => const PaymentScreen());

      case '/restaurant-view':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => RestaurantViewScreen(
            restaurantName: args?['restaurantName'] as String?,
            rating: args?['rating'] as double?,
            imageUrl: args?['imageUrl'] as String?,
          ),
        );

      case '/order-tracking':
        return MaterialPageRoute(builder: (_) => const OrderTrackingScreen());

      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      case '/address':
        return MaterialPageRoute(builder: (_) => const AddressScreen());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case '/review':
        return MaterialPageRoute(builder: (_) => const ReviewScreen());

      case '/user-reviews':
        return MaterialPageRoute(builder: (_) => const UserReviewsScreen());

      case '/offers':
        return PageRouteBuilder(
          opaque: false, // Makes background transparent
          pageBuilder: (context, _, __) => const OffersScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );

      case '/support':
        return MaterialPageRoute(builder: (_) => const SupportScreen());

      case '/food-category':
        final args = settings.arguments as Map<String, dynamic>?;
        final category = args?['category'] as String? ?? 'Burger';
        return MaterialPageRoute(
          builder: (_) => FoodCategoryScreen(category: category),
        );

      case '/add-card':
        return MaterialPageRoute(builder: (_) => const AddCardScreen());

      case '/filter':
        return PageRouteBuilder(
          opaque: false, // Makes background transparent
          pageBuilder: (context, _, __) => const FilterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );

      case '/payment-processing':
        return MaterialPageRoute(
          builder: (_) => const PaymentProcessingScreen(),
        );

      case '/payment-success':
        return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());

      case '/tracking-order-1':
        return MaterialPageRoute(builder: (_) => const TrackingOrder1Screen());

      case '/tracking-order-2':
        return MaterialPageRoute(builder: (_) => const TrackingOrder2Screen());

      case '/delivery-call':
        return PageRouteBuilder(
          opaque: false, // Makes background transparent
          pageBuilder: (context, _, __) => const DeliveryCallScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );

      case '/interactive-tracking':
        return MaterialPageRoute(
          builder: (_) => const InteractiveTrackingScreen(),
        );

      case '/delivery-message':
        return MaterialPageRoute(builder: (_) => const DeliveryMessageScreen());

      case '/personal-info':
        return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());

      case '/edit-profile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case '/add-address':
        return MaterialPageRoute(builder: (_) => const AddAddressScreen());

      case '/seller-dashboard':
        return MaterialPageRoute(builder: (_) => const SellerDashboardScreen());

      case '/popular-items':
        return MaterialPageRoute(builder: (_) => const PopularItemsScreen());

      case '/running-orders':
        return MaterialPageRoute(builder: (_) => const RunningOrdersScreen());

      case '/seller-reviews':
        return MaterialPageRoute(builder: (_) => const SellerReviewsScreen());

      case '/seller-notifications':
        return MaterialPageRoute(
          builder: (_) => const SellerNotificationsScreen(),
        );

      case '/my-food-list':
        return MaterialPageRoute(builder: (_) => const MyFoodListScreen());

      case '/seller-food-details':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SellerFoodDetailsScreen(
            foodName: args?['foodName'] as String?,
            price: args?['price'] as int?,
            category: args?['category'] as String?,
          ),
        );

      case '/add-new-food':
        return MaterialPageRoute(builder: (_) => const AddNewFoodScreen());

      case '/seller-profile':
        return MaterialPageRoute(builder: (_) => const SellerProfileScreen());

      case '/withdraw-success':
        return MaterialPageRoute(builder: (_) => const WithdrawSuccessScreen());

      case '/database-debug':
        return MaterialPageRoute(builder: (_) => const DatabaseDebugScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
