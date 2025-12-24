import '../entities/review.dart';

/// Review Repository interface - Domain layer
/// Defines the contract for review operations
abstract class ReviewRepository {
  /// Create a new review
  Future<Review> createReview(Review review);

  /// Get all reviews for a chef/seller
  Future<List<Review>> getChefReviews(String chefId);

  /// Get review by ID
  Future<Review?> getReviewById(String reviewId);

  /// Get reviews by user ID
  Future<List<Review>> getUserReviews(String userId);
}
