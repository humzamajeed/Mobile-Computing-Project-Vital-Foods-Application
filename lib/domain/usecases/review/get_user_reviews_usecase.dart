import '../../entities/review.dart';
import '../../repositories/review_repository.dart';

/// Get User Reviews Use Case
/// Retrieves all reviews submitted by a user
class GetUserReviewsUseCase {
  final ReviewRepository _reviewRepository;

  GetUserReviewsUseCase(this._reviewRepository);

  Future<List<Review>> call(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID cannot be empty');
    }

    return await _reviewRepository.getUserReviews(userId);
  }
}
