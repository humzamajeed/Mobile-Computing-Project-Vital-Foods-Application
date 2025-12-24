import '../entities/cart.dart';
import '../entities/cart_item.dart';

/// Cart Repository interface - Domain layer
/// Defines the contract for cart operations
abstract class CartRepository {
  /// Get user's cart
  Future<Cart> getCart(String userId);

  /// Add item to cart
  /// Returns updated cart
  Future<Cart> addToCart({required String userId, required CartItem item});

  /// Remove item from cart
  /// Returns updated cart
  Future<Cart> removeFromCart({required String userId, required String itemId});

  /// Update cart item quantity
  /// Returns updated cart
  Future<Cart> updateCartItemQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  });

  /// Clear entire cart
  /// Returns empty cart
  Future<Cart> clearCart(String userId);

  /// Stream cart changes in real-time
  Stream<Cart> watchCart(String userId);
}
