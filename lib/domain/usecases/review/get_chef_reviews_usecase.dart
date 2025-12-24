import '../../entities/review.dart';
import '../../repositories/review_repository.dart';

/// Get Chef Reviews Use Case
/// Retrieves all reviews for a chef
class GetChefReviewsUseCase {
  final ReviewRepository _reviewRepository;

  GetChefReviewsUseCase(this._reviewRepository);

  Future<List<Review>> call(String chefId) async {
    if (chefId.isEmpty) {
      throw Exception('Chef ID cannot be empty');
    }

    return await _reviewRepository.getChefReviews(chefId);
  }
}
