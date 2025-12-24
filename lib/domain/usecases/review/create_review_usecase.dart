import '../../entities/review.dart';
import '../../repositories/review_repository.dart';

/// Create Review Use Case
/// Creates a new review
class CreateReviewUseCase {
  final ReviewRepository _reviewRepository;

  CreateReviewUseCase(this._reviewRepository);

  Future<Review> call(Review review) async {
    // Validation
    if (review.rating < 1 || review.rating > 5) {
      throw Exception('Rating must be between 1 and 5');
    }

    if (review.title.trim().isEmpty) {
      throw Exception('Review title cannot be empty');
    }

    if (review.userId.isEmpty) {
      throw Exception('User ID cannot be empty');
    }

    if (review.chefId.isEmpty) {
      throw Exception('Chef ID cannot be empty');
    }

    return await _reviewRepository.createReview(review);
  }
}
