import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/favorite_item.dart';
import '../models/favorite_item_model.dart';

/// Favorite Remote Data Source - Data layer
/// Handles Firebase Firestore operations for favorites
class FavoriteRemoteDataSource {
  final FirebaseFirestore _firestore;

  FavoriteRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collection = 'favorites';

  /// Get user's favorites from Firestore
  Future<List<FavoriteItem>> getFavorites(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map(
            (doc) => FavoriteItemModel.fromJson({'id': doc.id, ...doc.data()}),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get favorites: ${e.toString()}');
    }
  }

  /// Add item to favorites
  Future<FavoriteItem> addFavorite({
    required String userId,
    required String foodName,
    String? restaurantName,
    required int price,
    required String imageUrl,
  }) async {
    try {
      // Check if already favorited
      final existing = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('foodName', isEqualTo: foodName)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        // Already favorited, return existing
        return FavoriteItemModel.fromJson({
          'id': existing.docs.first.id,
          ...existing.docs.first.data(),
        });
      }

      // Add new favorite
      final docRef = await _firestore.collection(_collection).add({
        'userId': userId,
        'foodName': foodName,
        'restaurantName': restaurantName,
        'price': price,
        'imageUrl': imageUrl,
        'createdAt': DateTime.now().toIso8601String(),
      });

      return FavoriteItemModel(
        id: docRef.id,
        foodName: foodName,
        restaurantName: restaurantName,
        price: price,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to add favorite: ${e.toString()}');
    }
  }

  /// Remove item from favorites
  Future<void> removeFavorite({
    required String userId,
    required String foodName,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('foodName', isEqualTo: foodName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to remove favorite: ${e.toString()}');
    }
  }

  /// Check if item is favorited
  Future<bool> isFavorite({
    required String userId,
    required String foodName,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('foodName', isEqualTo: foodName)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
