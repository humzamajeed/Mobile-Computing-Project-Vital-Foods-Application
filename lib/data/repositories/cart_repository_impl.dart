import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

/// Cart Repository Implementation - Data layer
/// Implements CartRepository interface using Firebase
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Cart> getCart(String userId) async {
    try {
      return await _remoteDataSource.getCart(userId);
    } catch (e) {
      throw Exception('Failed to get cart: ${e.toString()}');
    }
  }

  @override
  Future<Cart> addToCart({
    required String userId,
    required CartItem item,
  }) async {
    try {
      return await _remoteDataSource.addToCart(userId: userId, item: item);
    } catch (e) {
      throw Exception('Failed to add to cart: ${e.toString()}');
    }
  }

  @override
  Future<Cart> removeFromCart({
    required String userId,
    required String itemId,
  }) async {
    try {
      return await _remoteDataSource.removeFromCart(
        userId: userId,
        itemId: itemId,
      );
    } catch (e) {
      throw Exception('Failed to remove from cart: ${e.toString()}');
    }
  }

  @override
  Future<Cart> updateCartItemQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  }) async {
    try {
      return await _remoteDataSource.updateCartItemQuantity(
        userId: userId,
        itemId: itemId,
        quantity: quantity,
      );
    } catch (e) {
      throw Exception('Failed to update cart item quantity: ${e.toString()}');
    }
  }

  @override
  Future<Cart> clearCart(String userId) async {
    try {
      return await _remoteDataSource.clearCart(userId);
    } catch (e) {
      throw Exception('Failed to clear cart: ${e.toString()}');
    }
  }

  @override
  Stream<Cart> watchCart(String userId) {
    try {
      return _remoteDataSource.watchCart(userId);
    } catch (e) {
      throw Exception('Failed to watch cart: ${e.toString()}');
    }
  }
}
