import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Database Cleanup Service
/// Handles clearing all Firestore collections
class DatabaseCleanupService {
  final FirebaseFirestore _firestore;

  DatabaseCleanupService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// List of all collections to clean up
  static const List<String> _collections = [
    'users',
    'carts',
    'orders',
    'reviews',
    'favorites',
    'addresses',
    'notifications',
  ];

  /// Clear all documents from all collections
  /// Returns true if successful, false otherwise
  Future<bool> clearAllCollections() async {
    try {
      debugPrint('🧹 Starting database cleanup...');

      for (final collectionName in _collections) {
        await _clearCollection(collectionName);
      }

      debugPrint('✅ Database cleanup completed successfully');
      return true;
    } catch (e) {
      debugPrint('❌ Error during database cleanup: $e');
      return false;
    }
  }

  /// Clear all documents from a specific collection
  Future<void> _clearCollection(String collectionName) async {
    try {
      debugPrint('   Clearing collection: $collectionName');

      final collectionRef = _firestore.collection(collectionName);
      final snapshot = await collectionRef.get();

      if (snapshot.docs.isEmpty) {
        debugPrint('   → Collection $collectionName is already empty');
        return;
      }

      // Delete all documents in batches
      final batch = _firestore.batch();
      int batchCount = 0;
      const batchLimit = 500; // Firestore batch limit

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
        batchCount++;

        // Commit batch when limit is reached
        if (batchCount >= batchLimit) {
          await batch.commit();
          debugPrint('   → Deleted $batchCount documents from $collectionName');
          batchCount = 0;
        }
      }

      // Commit remaining documents
      if (batchCount > 0) {
        await batch.commit();
        debugPrint('   → Deleted $batchCount documents from $collectionName');
      }

      debugPrint(
        '   ✅ Cleared $collectionName (${snapshot.docs.length} documents)',
      );
    } catch (e) {
      debugPrint('   ❌ Error clearing $collectionName: $e');
      rethrow;
    }
  }

  /// Get collection statistics (document counts)
  Future<Map<String, int>> getCollectionStats() async {
    final stats = <String, int>{};

    try {
      for (final collectionName in _collections) {
        final snapshot = await _firestore.collection(collectionName).get();
        stats[collectionName] = snapshot.docs.length;
      }
    } catch (e) {
      debugPrint('Error getting collection stats: $e');
    }

    return stats;
  }

  /// Get all documents from a collection (for debug viewing)
  Future<List<Map<String, dynamic>>> getCollectionData(
    String collectionName,
  ) async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      debugPrint('Error getting collection data: $e');
      return [];
    }
  }

  /// Clear a specific collection by name
  Future<bool> clearCollection(String collectionName) async {
    try {
      await _clearCollection(collectionName);
      return true;
    } catch (e) {
      debugPrint('Error clearing collection $collectionName: $e');
      return false;
    }
  }
}
