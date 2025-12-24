import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/review_remote_datasource.dart';

/// Review Repository Implementation - Data layer
/// Implements ReviewRepository interface using Firebase
class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource _remoteDataSource;

  ReviewRepositoryImpl(this._remoteDataSource);

  @override
  Future<Review> createReview(Review review) async {
    try {
      return await _remoteDataSource.createReview(review);
    } catch (e) {
      throw Exception('Failed to create review: ${e.toString()}');
    }
  }

  @override
  Future<List<Review>> getChefReviews(String chefId) async {
    try {
      return await _remoteDataSource.getChefReviews(chefId);
    } catch (e) {
      throw Exception('Failed to get chef reviews: ${e.toString()}');
    }
  }

  @override
  Future<Review?> getReviewById(String reviewId) async {
    try {
      return await _remoteDataSource.getReviewById(reviewId);
    } catch (e) {
      throw Exception('Failed to get review by ID: ${e.toString()}');
    }
  }

  @override
  Future<List<Review>> getUserReviews(String userId) async {
    try {
      return await _remoteDataSource.getUserReviews(userId);
    } catch (e) {
      throw Exception('Failed to get user reviews: ${e.toString()}');
    }
  }
}
