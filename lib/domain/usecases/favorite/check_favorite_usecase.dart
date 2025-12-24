import '../../repositories/favorite_repository.dart';

/// Check Favorite Use Case - Domain layer
class CheckFavoriteUseCase {
  final FavoriteRepository _repository;

  CheckFavoriteUseCase(this._repository);

  Future<bool> call({required String userId, required String foodName}) async {
    return await _repository.isFavorite(userId: userId, foodName: foodName);
  }
}
