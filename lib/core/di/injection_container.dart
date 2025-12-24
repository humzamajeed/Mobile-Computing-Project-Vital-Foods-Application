import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/settings_remote_datasource.dart';
import '../../data/datasources/cart_remote_datasource.dart';
import '../../data/datasources/favorite_remote_datasource.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/datasources/review_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/review_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/review_repository.dart';
import '../../domain/usecases/auth/sign_in_usecase.dart';
import '../../domain/usecases/auth/sign_up_usecase.dart';
import '../../domain/usecases/auth/sign_out_usecase.dart';
import '../../domain/usecases/auth/forgot_password_usecase.dart';
import '../../domain/usecases/auth/delete_account_usecase.dart';
import '../../domain/usecases/settings/get_settings_usecase.dart';
import '../../domain/usecases/settings/update_settings_usecase.dart';
import '../../domain/usecases/settings/update_profile_usecase.dart';
import '../../domain/usecases/settings/change_password_usecase.dart';
import '../../domain/usecases/cart/get_cart_usecase.dart';
import '../../domain/usecases/cart/add_to_cart_usecase.dart';
import '../../domain/usecases/cart/remove_from_cart_usecase.dart';
import '../../domain/usecases/cart/update_cart_item_quantity_usecase.dart';
import '../../domain/usecases/cart/clear_cart_usecase.dart';
import '../../domain/usecases/favorite/get_favorites_usecase.dart';
import '../../domain/usecases/favorite/add_favorite_usecase.dart';
import '../../domain/usecases/favorite/remove_favorite_usecase.dart';
import '../../domain/usecases/favorite/check_favorite_usecase.dart';
import '../../domain/usecases/order/create_order_usecase.dart';
import '../../domain/usecases/order/get_user_orders_usecase.dart';
import '../../domain/usecases/order/get_order_by_id_usecase.dart';
import '../../domain/usecases/order/update_order_status_usecase.dart';
import '../../domain/usecases/order/delete_order_usecase.dart';
import '../../domain/usecases/review/create_review_usecase.dart';
import '../../domain/usecases/review/get_chef_reviews_usecase.dart';
import '../../domain/usecases/review/get_user_reviews_usecase.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/settings_provider.dart';
import '../../presentation/providers/cart_provider.dart';
import '../../presentation/providers/favorite_provider.dart';
import '../../presentation/providers/order_provider.dart';
import '../../presentation/providers/review_provider.dart';
import '../../presentation/providers/locale_provider.dart';
import '../../core/services/database_cleanup_service.dart';

/// Dependency injection container
/// Provides instances of all dependencies
class InjectionContainer {
  // Data sources
  late final AuthRemoteDataSource _authRemoteDataSource;
  late final SettingsRemoteDataSource _settingsRemoteDataSource;
  late final CartRemoteDataSource _cartRemoteDataSource;
  late final FavoriteRemoteDataSource _favoriteRemoteDataSource;
  late final OrderRemoteDataSource _orderRemoteDataSource;
  late final ReviewRemoteDataSource _reviewRemoteDataSource;

  // Repositories
  late final AuthRepository _authRepository;
  late final SettingsRepository _settingsRepository;
  late final CartRepository _cartRepository;
  late final FavoriteRepository _favoriteRepository;
  late final OrderRepository _orderRepository;
  late final ReviewRepository _reviewRepository;

  // Use cases
  late final SignInUseCase _signInUseCase;
  late final SignUpUseCase _signUpUseCase;
  late final SignOutUseCase _signOutUseCase;
  late final ForgotPasswordUseCase _forgotPasswordUseCase;
  late final DeleteAccountUseCase _deleteAccountUseCase;
  late final GetSettingsUseCase _getSettingsUseCase;
  late final UpdateSettingsUseCase _updateSettingsUseCase;
  late final UpdateProfileUseCase _updateProfileUseCase;
  late final ChangePasswordUseCase _changePasswordUseCase;
  late final GetCartUseCase _getCartUseCase;
  late final AddToCartUseCase _addToCartUseCase;
  late final RemoveFromCartUseCase _removeFromCartUseCase;
  late final UpdateCartItemQuantityUseCase _updateCartItemQuantityUseCase;
  late final ClearCartUseCase _clearCartUseCase;
  late final GetFavoritesUseCase _getFavoritesUseCase;
  late final AddFavoriteUseCase _addFavoriteUseCase;
  late final RemoveFavoriteUseCase _removeFavoriteUseCase;
  late final CheckFavoriteUseCase _checkFavoriteUseCase;
  late final CreateOrderUseCase _createOrderUseCase;
  late final GetUserOrdersUseCase _getUserOrdersUseCase;
  late final GetOrderByIdUseCase _getOrderByIdUseCase;
  late final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  late final DeleteOrderUseCase _deleteOrderUseCase;
  late final CreateReviewUseCase _createReviewUseCase;
  late final GetChefReviewsUseCase _getChefReviewsUseCase;
  late final GetUserReviewsUseCase _getUserReviewsUseCase;

  // Services
  late final DatabaseCleanupService _databaseCleanupService;

  // Providers
  late final AuthProvider _authProvider;
  late final SettingsProvider _settingsProvider;
  late final CartProvider _cartProvider;
  late final FavoriteProvider _favoriteProvider;
  late final OrderProvider _orderProvider;
  late final ReviewProvider _reviewProvider;
  late final LocaleProvider _localeProvider;

  InjectionContainer() {
    _initialize();
  }

  void _initialize() {
    // Initialize Firebase instances
    final firebaseAuth = firebase_auth.FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    // Initialize services
    _databaseCleanupService = DatabaseCleanupService(firestore: firestore);

    // Initialize data sources
    _authRemoteDataSource = AuthRemoteDataSource(
      firebaseAuth: firebaseAuth,
      firestore: firestore,
    );
    _settingsRemoteDataSource = SettingsRemoteDataSource(
      firestore: firestore,
      firebaseAuth: firebaseAuth,
    );
    _cartRemoteDataSource = CartRemoteDataSource(firestore: firestore);
    _favoriteRemoteDataSource = FavoriteRemoteDataSource(firestore: firestore);
    _orderRemoteDataSource = OrderRemoteDataSource(firestore: firestore);
    _reviewRemoteDataSource = ReviewRemoteDataSource(firestore: firestore);

    // Initialize repositories
    _authRepository = AuthRepositoryImpl(_authRemoteDataSource);
    _settingsRepository = SettingsRepositoryImpl(_settingsRemoteDataSource);
    _cartRepository = CartRepositoryImpl(_cartRemoteDataSource);
    _favoriteRepository = FavoriteRepositoryImpl(_favoriteRemoteDataSource);
    _orderRepository = OrderRepositoryImpl(_orderRemoteDataSource);
    _reviewRepository = ReviewRepositoryImpl(_reviewRemoteDataSource);

    // Initialize use cases
    _signInUseCase = SignInUseCase(_authRepository);
    _signUpUseCase = SignUpUseCase(_authRepository);
    _signOutUseCase = SignOutUseCase(_authRepository);
    _forgotPasswordUseCase = ForgotPasswordUseCase(_authRepository);
    _deleteAccountUseCase = DeleteAccountUseCase(_authRepository);
    _getSettingsUseCase = GetSettingsUseCase(_settingsRepository);
    _updateSettingsUseCase = UpdateSettingsUseCase(_settingsRepository);
    _updateProfileUseCase = UpdateProfileUseCase(_settingsRepository);
    _changePasswordUseCase = ChangePasswordUseCase(_settingsRepository);
    _getCartUseCase = GetCartUseCase(_cartRepository);
    _addToCartUseCase = AddToCartUseCase(_cartRepository);
    _removeFromCartUseCase = RemoveFromCartUseCase(_cartRepository);
    _updateCartItemQuantityUseCase = UpdateCartItemQuantityUseCase(
      _cartRepository,
    );
    _clearCartUseCase = ClearCartUseCase(_cartRepository);
    _getFavoritesUseCase = GetFavoritesUseCase(_favoriteRepository);
    _addFavoriteUseCase = AddFavoriteUseCase(_favoriteRepository);
    _removeFavoriteUseCase = RemoveFavoriteUseCase(_favoriteRepository);
    _checkFavoriteUseCase = CheckFavoriteUseCase(_favoriteRepository);
    _createOrderUseCase = CreateOrderUseCase(_orderRepository);
    _getUserOrdersUseCase = GetUserOrdersUseCase(_orderRepository);
    _getOrderByIdUseCase = GetOrderByIdUseCase(_orderRepository);
    _updateOrderStatusUseCase = UpdateOrderStatusUseCase(_orderRepository);
    _deleteOrderUseCase = DeleteOrderUseCase(_orderRepository);
    _createReviewUseCase = CreateReviewUseCase(_reviewRepository);
    _getChefReviewsUseCase = GetChefReviewsUseCase(_reviewRepository);
    _getUserReviewsUseCase = GetUserReviewsUseCase(_reviewRepository);

    // Initialize providers
    _authProvider = AuthProvider(
      signInUseCase: _signInUseCase,
      signUpUseCase: _signUpUseCase,
      signOutUseCase: _signOutUseCase,
      forgotPasswordUseCase: _forgotPasswordUseCase,
      deleteAccountUseCase: _deleteAccountUseCase,
      authRepository: _authRepository,
      databaseCleanupService: _databaseCleanupService,
    );
    _settingsProvider = SettingsProvider(
      getSettingsUseCase: _getSettingsUseCase,
      updateSettingsUseCase: _updateSettingsUseCase,
      updateProfileUseCase: _updateProfileUseCase,
      changePasswordUseCase: _changePasswordUseCase,
    );
    _cartProvider = CartProvider(
      getCartUseCase: _getCartUseCase,
      addToCartUseCase: _addToCartUseCase,
      removeFromCartUseCase: _removeFromCartUseCase,
      updateCartItemQuantityUseCase: _updateCartItemQuantityUseCase,
      clearCartUseCase: _clearCartUseCase,
    );
    _favoriteProvider = FavoriteProvider(
      getFavoritesUseCase: _getFavoritesUseCase,
      addFavoriteUseCase: _addFavoriteUseCase,
      removeFavoriteUseCase: _removeFavoriteUseCase,
      checkFavoriteUseCase: _checkFavoriteUseCase,
    );
    _orderProvider = OrderProvider(
      createOrderUseCase: _createOrderUseCase,
      getUserOrdersUseCase: _getUserOrdersUseCase,
      getOrderByIdUseCase: _getOrderByIdUseCase,
      updateOrderStatusUseCase: _updateOrderStatusUseCase,
      deleteOrderUseCase: _deleteOrderUseCase,
    );
    _reviewProvider = ReviewProvider(
      createReviewUseCase: _createReviewUseCase,
      getChefReviewsUseCase: _getChefReviewsUseCase,
      getUserReviewsUseCase: _getUserReviewsUseCase,
    );
    _localeProvider = LocaleProvider();
  }

  // Getters
  DatabaseCleanupService get databaseCleanupService => _databaseCleanupService;
  AuthProvider get authProvider => _authProvider;
  SettingsProvider get settingsProvider => _settingsProvider;
  CartProvider get cartProvider => _cartProvider;
  FavoriteProvider get favoriteProvider => _favoriteProvider;
  OrderProvider get orderProvider => _orderProvider;
  ReviewProvider get reviewProvider => _reviewProvider;
  LocaleProvider get localeProvider => _localeProvider;
  AuthRepository get authRepository => _authRepository;
  SettingsRepository get settingsRepository => _settingsRepository;
  CartRepository get cartRepository => _cartRepository;
}
