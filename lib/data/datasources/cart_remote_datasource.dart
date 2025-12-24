import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../models/cart_model.dart';
import '../models/cart_item_model.dart';

/// Cart Remote Data Source - Data layer
/// Handles Firebase Firestore operations for cart
class CartRemoteDataSource {
  final FirebaseFirestore _firestore;

  CartRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collection = 'carts';

  /// Get user's cart from Firestore
  Future<Cart> getCart(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();

      if (!doc.exists || doc.data() == null) {
        // Return empty cart if document doesn't exist
        return CartModel(userId: userId, items: []);
      }

      return CartModel.fromJson({'userId': userId, ...doc.data()!});
    } catch (e) {
      throw Exception('Failed to get cart: ${e.toString()}');
    }
  }

  /// Add item to cart
  Future<Cart> addToCart({
    required String userId,
    required CartItem item,
  }) async {
    try {
      final cartRef = _firestore.collection(_collection).doc(userId);
      final cartDoc = await cartRef.get();

      List<CartItemModel> items = [];
      if (cartDoc.exists && cartDoc.data() != null) {
        final cartData = cartDoc.data()!;
        items =
            (cartData['items'] as List<dynamic>?)
                ?.map(
                  (item) =>
                      CartItemModel.fromJson(item as Map<String, dynamic>),
                )
                .toList() ??
            [];
      }

      // Check if item with same id already exists, update quantity if it does
      final existingIndex = items.indexWhere((i) => i.id == item.id);
      if (existingIndex != -1) {
        // Item exists, update quantity
        items[existingIndex] = CartItemModel(
          id: items[existingIndex].id,
          foodName: items[existingIndex].foodName,
          restaurantName: items[existingIndex].restaurantName,
          price: items[existingIndex].price,
          quantity: items[existingIndex].quantity + item.quantity,
          imageUrl: items[existingIndex].imageUrl,
          size: items[existingIndex].size,
          createdAt: items[existingIndex].createdAt,
          updatedAt: DateTime.now(),
        );
      } else {
        // New item, add to list
        items.add(CartItemModel.fromEntity(item));
      }

      await cartRef.set({
        'userId': userId,
        'items': items.map((item) => item.toJson()).toList(),
        'updatedAt': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true));

      return CartModel(userId: userId, items: items, updatedAt: DateTime.now());
    } catch (e) {
      throw Exception('Failed to add to cart: ${e.toString()}');
    }
  }

  /// Remove item from cart
  Future<Cart> removeFromCart({
    required String userId,
    required String itemId,
  }) async {
    try {
      final cartRef = _firestore.collection(_collection).doc(userId);
      final cartDoc = await cartRef.get();

      if (!cartDoc.exists || cartDoc.data() == null) {
        return CartModel(userId: userId, items: []);
      }

      final cartData = cartDoc.data()!;
      List<CartItemModel> items =
          (cartData['items'] as List<dynamic>?)
              ?.map(
                (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [];

      items.removeWhere((item) => item.id == itemId);

      await cartRef.set({
        'userId': userId,
        'items': items.map((item) => item.toJson()).toList(),
        'updatedAt': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true));

      return CartModel(userId: userId, items: items, updatedAt: DateTime.now());
    } catch (e) {
      throw Exception('Failed to remove from cart: ${e.toString()}');
    }
  }

  /// Update cart item quantity
  Future<Cart> updateCartItemQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  }) async {
    try {
      final cartRef = _firestore.collection(_collection).doc(userId);
      final cartDoc = await cartRef.get();

      if (!cartDoc.exists || cartDoc.data() == null) {
        throw Exception('Cart not found');
      }

      final cartData = cartDoc.data()!;
      List<CartItemModel> items =
          (cartData['items'] as List<dynamic>?)
              ?.map(
                (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [];

      final itemIndex = items.indexWhere((item) => item.id == itemId);
      if (itemIndex == -1) {
        throw Exception('Item not found in cart');
      }

      items[itemIndex] = CartItemModel(
        id: items[itemIndex].id,
        foodName: items[itemIndex].foodName,
        restaurantName: items[itemIndex].restaurantName,
        price: items[itemIndex].price,
        quantity: quantity,
        imageUrl: items[itemIndex].imageUrl,
        size: items[itemIndex].size,
        createdAt: items[itemIndex].createdAt,
        updatedAt: DateTime.now(),
      );

      await cartRef.set({
        'userId': userId,
        'items': items.map((item) => item.toJson()).toList(),
        'updatedAt': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true));

      return CartModel(userId: userId, items: items, updatedAt: DateTime.now());
    } catch (e) {
      throw Exception('Failed to update cart item quantity: ${e.toString()}');
    }
  }

  /// Clear entire cart
  Future<Cart> clearCart(String userId) async {
    try {
      final cartRef = _firestore.collection(_collection).doc(userId);
      await cartRef.set({
        'userId': userId,
        'items': <Map<String, dynamic>>[],
        'updatedAt': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true));

      return CartModel(userId: userId, items: [], updatedAt: DateTime.now());
    } catch (e) {
      throw Exception('Failed to clear cart: ${e.toString()}');
    }
  }

  /// Stream cart changes in real-time
  Stream<Cart> watchCart(String userId) {
    try {
      return _firestore.collection(_collection).doc(userId).snapshots().map((
        snapshot,
      ) {
        if (!snapshot.exists || snapshot.data() == null) {
          return CartModel(userId: userId, items: []);
        }

        return CartModel.fromJson({'userId': userId, ...snapshot.data()!});
      });
    } catch (e) {
      throw Exception('Failed to watch cart: ${e.toString()}');
    }
  }
}
