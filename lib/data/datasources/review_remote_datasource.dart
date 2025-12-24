import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review.dart' as domain;
import '../models/review_model.dart';

/// Review Remote Data Source - Data layer
/// Handles Firebase Firestore operations for reviews
class ReviewRemoteDataSource {
  final FirebaseFirestore _firestore;

  ReviewRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collection = 'reviews';

  /// Create a new review in Firestore
  Future<domain.Review> createReview(domain.Review review) async {
    try {
      final reviewModel = ReviewModel.fromEntity(review);
      final reviewRef = _firestore.collection(_collection).doc();

      final reviewData = reviewModel.toJson();
      reviewData['id'] = reviewRef.id;

      // Ensure chefId is a string (not null)
      if (reviewData['chefId'] == null ||
          reviewData['chefId'].toString().isEmpty) {
        throw Exception('Chef ID cannot be null or empty');
      }

      debugPrint('📝 Creating review in Firestore:');
      debugPrint('   - Collection: $_collection');
      debugPrint('   - Document ID: ${reviewRef.id}');
      debugPrint('   - User ID: ${review.userId}');
      debugPrint('   - User Name: ${review.userName}');
      debugPrint('   - User Image: ${review.userImageUrl ?? "none"}');
      debugPrint(
        '   - Chef ID: ${review.chefId} (type: ${review.chefId.runtimeType})',
      );
      debugPrint('   - Chef Name: ${review.chefName ?? "none"}');
      debugPrint('   - Chef Image: ${review.chefImageUrl ?? "none"}');
      debugPrint('   - Rating: ${review.rating}');
      debugPrint('   - Title: ${review.title}');
      debugPrint('   - Review Text: ${review.reviewText ?? "none"}');
      debugPrint(
        '   - Tags: ${review.tags ?? "none"} (count: ${review.tags?.length ?? 0})',
      );
      debugPrint('   - Full reviewData: $reviewData');

      await reviewRef.set(reviewData);

      // Verify the saved data
      final savedDoc = await reviewRef.get();
      if (savedDoc.exists) {
        final savedData = savedDoc.data();
        debugPrint('✅ Review saved successfully');
        debugPrint('   - Saved Chef ID: ${savedData?['chefId']}');
        debugPrint('   - Saved User ID: ${savedData?['userId']}');
      }

      debugPrint(
        '✅ Review successfully saved to Firestore with ID: ${reviewRef.id}',
      );

      return ReviewModel.fromJson({'id': reviewRef.id, ...reviewData});
    } catch (e) {
      debugPrint('❌ Error creating review: $e');
      throw Exception('Failed to create review: ${e.toString()}');
    }
  }

  /// Get all reviews for a chef
  Future<List<domain.Review>> getChefReviews(String chefId) async {
    try {
      debugPrint('🔍 Fetching reviews for chef: $chefId');
      debugPrint('   - Collection: $_collection');

      // First, get all reviews to debug
      final allReviewsSnapshot = await _firestore.collection(_collection).get();

      debugPrint(
        '📊 Total reviews in collection: ${allReviewsSnapshot.docs.length}',
      );

      if (allReviewsSnapshot.docs.isNotEmpty) {
        debugPrint('   All reviews chefIds:');
        for (var doc in allReviewsSnapshot.docs) {
          final data = doc.data();
          debugPrint('     - Review ${doc.id}: chefId = ${data['chefId']}');
        }
      }

      // Now query for specific chef - try exact match first
      var querySnapshot = await _firestore
          .collection(_collection)
          .where('chefId', isEqualTo: chefId)
          .get();

      debugPrint(
        '📊 Found ${querySnapshot.docs.length} reviews for chef $chefId (exact match)',
      );

      // If no exact match, try manual filtering from all reviews
      List<QueryDocumentSnapshot> docsToProcess = querySnapshot.docs;
      if (querySnapshot.docs.isEmpty && allReviewsSnapshot.docs.isNotEmpty) {
        debugPrint('   ⚠️ No exact match found, trying manual filtering...');
        final matchingDocs = <QueryDocumentSnapshot>[];
        for (var doc in allReviewsSnapshot.docs) {
          final data = doc.data();
          final docChefId = data['chefId']?.toString() ?? '';
          // Try both exact match and trimmed match
          final trimmedDocChefId = docChefId.trim();
          final trimmedChefId = chefId.trim();
          debugPrint(
            '     Checking review ${doc.id}: chefId="$docChefId" vs query="$chefId"',
          );

          // Match if: exact match, trimmed match, or if review has "default_chef"
          // Since existing reviews have "default_chef", include them for any chef viewing reviews
          bool matches =
              docChefId == chefId ||
              trimmedDocChefId == trimmedChefId ||
              docChefId.contains(chefId) ||
              chefId.contains(docChefId);

          // Special case: if review has "default_chef", include it for any chef
          // This handles existing reviews that were saved with default_chef
          if (!matches && docChefId == 'default_chef') {
            matches = true;
            debugPrint('     ✓ Including default_chef review (legacy review)');
          }

          if (matches) {
            matchingDocs.add(doc);
            debugPrint('     ✓ Found matching review: ${doc.id}');
          }
        }

        if (matchingDocs.isNotEmpty) {
          docsToProcess = matchingDocs;
          debugPrint(
            '📊 Found ${docsToProcess.length} reviews after manual filtering',
          );
        }
      }

      final reviews = docsToProcess.map((doc) {
        final data = doc.data();
        if (data == null) {
          throw Exception('Review document ${doc.id} has no data');
        }
        final dataMap = data as Map<String, dynamic>;
        debugPrint('   - Review ID: ${doc.id}');
        debugPrint('     Chef ID in doc: ${dataMap['chefId']}');
        debugPrint('     User: ${dataMap['userName']}');
        debugPrint('     Rating: ${dataMap['rating']}');
        return ReviewModel.fromJson({'id': doc.id, ...dataMap});
      }).toList();

      // Sort by createdAt descending
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      debugPrint('✅ Returning ${reviews.length} sorted reviews');
      return reviews;
    } catch (e) {
      debugPrint('❌ Error getting chef reviews: $e');
      debugPrint('   Stack trace: ${StackTrace.current}');
      throw Exception('Failed to get chef reviews: ${e.toString()}');
    }
  }

  /// Get review by ID
  Future<domain.Review?> getReviewById(String reviewId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(reviewId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      return ReviewModel.fromJson({'id': doc.id, ...doc.data()!});
    } catch (e) {
      throw Exception('Failed to get review by ID: ${e.toString()}');
    }
  }

  /// Get reviews by user ID
  Future<List<domain.Review>> getUserReviews(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();

      final reviews = querySnapshot.docs.map((doc) {
        return ReviewModel.fromJson({'id': doc.id, ...doc.data()});
      }).toList();

      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return reviews;
    } catch (e) {
      throw Exception('Failed to get user reviews: ${e.toString()}');
    }
  }
}
