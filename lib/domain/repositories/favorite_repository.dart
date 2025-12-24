import '../entities/favorite_item.dart';

/// Favorite Repository - Domain layer
/// Abstract interface for favorite operations
abstract class FavoriteRepository {
  Future<List<FavoriteItem>> getFavorites(String userId);
  Future<FavoriteItem> addFavorite({
    required String userId,
    required String foodName,
    String? restaurantName,
    required int price,
    required String imageUrl,
  });
  Future<void> removeFavorite({
    required String userId,
    required String foodName,
  });
  Future<bool> isFavorite({required String userId, required String foodName});
}
