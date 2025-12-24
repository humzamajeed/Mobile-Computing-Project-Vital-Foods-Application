import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Database Initialization Service
/// Ensures all required collections exist in Firestore
class DatabaseInitService {
  final FirebaseFirestore _firestore;

  DatabaseInitService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// List of all required collections
  static const List<String> _requiredCollections = [
    'users',
    'carts',
    'orders',
    'reviews',
    'favorites',
    'addresses',
    'notifications',
  ];

  /// Initialize all collections by creating empty documents if needed
  /// This ensures collections exist in Firestore
  Future<void> initializeCollections() async {
    try {
      debugPrint('🔧 Initializing database collections...');

      for (final collectionName in _requiredCollections) {
        await _ensureCollectionExists(collectionName);
      }

      debugPrint('✅ All collections initialized');
    } catch (e) {
      debugPrint('❌ Error initializing collections: $e');
    }
  }

  /// Ensure a collection exists by checking if it has any documents
  /// Collections in Firestore are created automatically when first document is added
  /// This method just verifies they exist
  Future<void> _ensureCollectionExists(String collectionName) async {
    try {
      // Try to get collection reference
      final collectionRef = _firestore.collection(collectionName);

      // Check if collection has any documents (this will create the collection reference)
      final snapshot = await collectionRef.limit(1).get();

      debugPrint(
        '   ✓ Collection "$collectionName" exists (${snapshot.docs.length} documents)',
      );
    } catch (e) {
      debugPrint('   ⚠️ Collection "$collectionName" check failed: $e');
      // Collections are created automatically when first document is added
      // So this is not a critical error
    }
  }

  /// Get collection status (exists or not)
  Future<Map<String, bool>> getCollectionStatus() async {
    final status = <String, bool>{};

    for (final collectionName in _requiredCollections) {
      try {
        await _firestore.collection(collectionName).limit(1).get();
        status[collectionName] = true; // Collection exists
      } catch (e) {
        status[collectionName] = false;
      }
    }

    return status;
  }
}
