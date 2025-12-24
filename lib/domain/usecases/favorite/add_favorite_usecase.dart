import '../../entities/favorite_item.dart';
import '../../repositories/favorite_repository.dart';

/// Add Favorite Use Case - Domain layer
class AddFavoriteUseCase {
  final FavoriteRepository _repository;

  AddFavoriteUseCase(this._repository);

  Future<FavoriteItem> call({
    required String userId,
    required String foodName,
    String? restaurantName,
    required int price,
    required String imageUrl,
  }) async {
    return await _repository.addFavorite(
      userId: userId,
      foodName: foodName,
      restaurantName: restaurantName,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
