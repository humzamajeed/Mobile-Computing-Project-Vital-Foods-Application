import 'package:flutter/foundation.dart';
import '../../domain/entities/favorite_item.dart';
import '../../domain/usecases/favorite/get_favorites_usecase.dart';
import '../../domain/usecases/favorite/add_favorite_usecase.dart';
import '../../domain/usecases/favorite/remove_favorite_usecase.dart';
import '../../domain/usecases/favorite/check_favorite_usecase.dart';

/// Favorite Provider - Presentation layer
/// Manages favorite state using Provider
class FavoriteProvider with ChangeNotifier {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final CheckFavoriteUseCase _checkFavoriteUseCase;

  List<FavoriteItem> _favorites = [];
  bool _isLoading = false;
  String? _errorMessage;

  FavoriteProvider({
    required GetFavoritesUseCase getFavoritesUseCase,
    required AddFavoriteUseCase addFavoriteUseCase,
    required RemoveFavoriteUseCase removeFavoriteUseCase,
    required CheckFavoriteUseCase checkFavoriteUseCase,
  }) : _getFavoritesUseCase = getFavoritesUseCase,
       _addFavoriteUseCase = addFavoriteUseCase,
       _removeFavoriteUseCase = removeFavoriteUseCase,
       _checkFavoriteUseCase = checkFavoriteUseCase;

  // Getters
  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load favorites for user
  Future<void> loadFavorites(String userId) async {
    _setLoading(true);
    _clearError();

    try {
      _favorites = await _getFavoritesUseCase(userId);
      _clearError();
    } catch (e) {
      _setError('Failed to load favorites: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Add favorite
  Future<bool> addFavorite({
    required String userId,
    required String foodName,
    String? restaurantName,
    required int price,
    required String imageUrl,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final favorite = await _addFavoriteUseCase(
        userId: userId,
        foodName: foodName,
        restaurantName: restaurantName,
        price: price,
        imageUrl: imageUrl,
      );

      // Add to local list if not already present
      if (!_favorites.any((f) => f.id == favorite.id)) {
        _favorites.insert(0, favorite);
      }

      _clearError();
      return true;
    } catch (e) {
      _setError('Failed to add favorite: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Remove favorite
  Future<bool> removeFavorite({
    required String userId,
    required String foodName,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _removeFavoriteUseCase(userId: userId, foodName: foodName);

      // Remove from local list
      _favorites.removeWhere((f) => f.foodName == foodName);

      _clearError();
      return true;
    } catch (e) {
      _setError('Failed to remove favorite: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Check if item is favorited
  Future<bool> checkFavorite({
    required String userId,
    required String foodName,
  }) async {
    try {
      return await _checkFavoriteUseCase(userId: userId, foodName: foodName);
    } catch (e) {
      return false;
    }
  }

  /// Toggle favorite
  Future<bool> toggleFavorite({
    required String userId,
    required String foodName,
    String? restaurantName,
    required int price,
    required String imageUrl,
  }) async {
    final isFav = await checkFavorite(userId: userId, foodName: foodName);

    if (isFav) {
      return await removeFavorite(userId: userId, foodName: foodName);
    } else {
      return await addFavorite(
        userId: userId,
        foodName: foodName,
        restaurantName: restaurantName,
        price: price,
        imageUrl: imageUrl,
      );
    }
  }

  // Private helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
