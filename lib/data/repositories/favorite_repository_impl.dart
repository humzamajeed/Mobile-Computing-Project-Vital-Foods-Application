import '../../domain/entities/favorite_item.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_remote_datasource.dart';

/// Favorite Repository Implementation - Data layer
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource _remoteDataSource;

  FavoriteRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<FavoriteItem>> getFavorites(String userId) async {
    return await _remoteDataSource.getFavorites(userId);
  }

  @override
  Future<FavoriteItem> addFavorite({
    required String userId,
    required String foodName,
    String? restaurantName,
    required int price,
    required String imageUrl,
  }) async {
    return await _remoteDataSource.addFavorite(
      userId: userId,
      foodName: foodName,
      restaurantName: restaurantName,
      price: price,
      imageUrl: imageUrl,
    );
  }

  @override
  Future<void> removeFavorite({
    required String userId,
    required String foodName,
  }) async {
    await _remoteDataSource.removeFavorite(userId: userId, foodName: foodName);
  }

  @override
  Future<bool> isFavorite({
    required String userId,
    required String foodName,
  }) async {
    return await _remoteDataSource.isFavorite(
      userId: userId,
      foodName: foodName,
    );
  }
}
