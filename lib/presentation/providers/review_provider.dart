import 'package:flutter/foundation.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/review/create_review_usecase.dart';
import '../../domain/usecases/review/get_chef_reviews_usecase.dart';
import '../../domain/usecases/review/get_user_reviews_usecase.dart';

/// Review Provider - Presentation layer
/// Manages review state using Provider
class ReviewProvider with ChangeNotifier {
  final CreateReviewUseCase _createReviewUseCase;
  final GetChefReviewsUseCase _getChefReviewsUseCase;
  final GetUserReviewsUseCase _getUserReviewsUseCase;

  List<Review> _chefReviews = [];
  List<Review> _userReviews = [];
  bool _isLoading = false;
  String? _errorMessage;

  ReviewProvider({
    required CreateReviewUseCase createReviewUseCase,
    required GetChefReviewsUseCase getChefReviewsUseCase,
    required GetUserReviewsUseCase getUserReviewsUseCase,
  }) : _createReviewUseCase = createReviewUseCase,
       _getChefReviewsUseCase = getChefReviewsUseCase,
       _getUserReviewsUseCase = getUserReviewsUseCase;

  // Getters
  List<Review> get chefReviews => _chefReviews;
  List<Review> get userReviews => _userReviews;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Create a new review
  Future<Review?> createReview(Review review) async {
    _setLoading(true);
    _clearError();

    try {
      debugPrint('📝 ReviewProvider: Creating review...');
      debugPrint('   - Rating: ${review.rating}');
      debugPrint('   - Review text: ${review.reviewText ?? "none"}');
      debugPrint('   - Tags: ${review.tags ?? "none"}');

      final createdReview = await _createReviewUseCase(review);

      debugPrint(
        '✅ ReviewProvider: Review created successfully with ID: ${createdReview.id}',
      );
      _clearError();
      notifyListeners();
      return createdReview;
    } catch (e) {
      debugPrint('❌ ReviewProvider: Error creating review: $e');
      _setError('Failed to create review: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  /// Load reviews for a chef
  Future<void> loadChefReviews(String chefId) async {
    _setLoading(true);
    _clearError();

    try {
      debugPrint('📋 ReviewProvider: Loading reviews for chef: $chefId');
      final reviews = await _getChefReviewsUseCase(chefId);
      _chefReviews = reviews;
      debugPrint('📋 ReviewProvider: Got ${_chefReviews.length} reviews');
      _clearError();
      notifyListeners();
    } catch (e) {
      debugPrint('❌ ReviewProvider: Error loading reviews: $e');
      _setError('Failed to load reviews: ${e.toString()}');
      _chefReviews = []; // Clear on error
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Load reviews for a user
  Future<void> loadUserReviews(String userId) async {
    _setLoading(true);
    _clearError();

    try {
      debugPrint('📋 ReviewProvider: Loading reviews for user: $userId');
      _userReviews = await _getUserReviewsUseCase(userId);
      debugPrint('📋 ReviewProvider: Got ${_userReviews.length} user reviews');
      _clearError();
      notifyListeners();
    } catch (e) {
      debugPrint('❌ ReviewProvider: Error loading user reviews: $e');
      _setError('Failed to load user reviews: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Private helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
