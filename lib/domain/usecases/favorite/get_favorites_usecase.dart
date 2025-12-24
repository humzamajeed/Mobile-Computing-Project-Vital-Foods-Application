import '../../entities/favorite_item.dart';
import '../../repositories/favorite_repository.dart';

/// Get Favorites Use Case - Domain layer
class GetFavoritesUseCase {
  final FavoriteRepository _repository;

  GetFavoritesUseCase(this._repository);

  Future<List<FavoriteItem>> call(String userId) async {
    return await _repository.getFavorites(userId);
  }
}
