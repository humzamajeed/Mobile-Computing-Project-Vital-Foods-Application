import '../../repositories/favorite_repository.dart';

/// Remove Favorite Use Case - Domain layer
class RemoveFavoriteUseCase {
  final FavoriteRepository _repository;

  RemoveFavoriteUseCase(this._repository);

  Future<void> call({required String userId, required String foodName}) async {
    await _repository.removeFavorite(userId: userId, foodName: foodName);
  }
}
