import 'package:flutter/foundation.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/cart/get_cart_usecase.dart';
import '../../domain/usecases/cart/add_to_cart_usecase.dart';
import '../../domain/usecases/cart/remove_from_cart_usecase.dart';
import '../../domain/usecases/cart/update_cart_item_quantity_usecase.dart';
import '../../domain/usecases/cart/clear_cart_usecase.dart';

/// Cart Provider - Presentation layer
/// Manages cart state using Provider
class CartProvider with ChangeNotifier {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateCartItemQuantityUseCase _updateCartItemQuantityUseCase;
  final ClearCartUseCase _clearCartUseCase;

  Cart? _cart;
  bool _isLoading = false;
  String? _errorMessage;

  CartProvider({
    required GetCartUseCase getCartUseCase,
    required AddToCartUseCase addToCartUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase,
    required ClearCartUseCase clearCartUseCase,
  }) : _getCartUseCase = getCartUseCase,
       _addToCartUseCase = addToCartUseCase,
       _removeFromCartUseCase = removeFromCartUseCase,
       _updateCartItemQuantityUseCase = updateCartItemQuantityUseCase,
       _clearCartUseCase = clearCartUseCase;

  // Getters
  Cart? get cart => _cart;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEmpty => _cart?.isEmpty ?? true;
  int get itemCount => _cart?.itemCount ?? 0;
  double get totalPrice => _cart?.totalPrice ?? 0.0;
  List<CartItem> get items => _cart?.items ?? [];

  /// Load cart for user
  Future<void> loadCart(String userId) async {
    _setLoading(true);
    _clearError();

    try {
      _cart = await _getCartUseCase(userId);
      _clearError();
    } catch (e) {
      _setError('Failed to load cart: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Add item to cart
  Future<bool> addToCart({
    required String userId,
    required CartItem item,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _cart = await _addToCartUseCase(userId: userId, item: item);
      _clearError();
      return true;
    } catch (e) {
      _setError('Failed to add to cart: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Remove item from cart
  Future<bool> removeFromCart({
    required String userId,
    required String itemId,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _cart = await _removeFromCartUseCase(userId: userId, itemId: itemId);
      _clearError();
      return true;
    } catch (e) {
      _setError('Failed to remove from cart: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update cart item quantity
  Future<bool> updateCartItemQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _cart = await _updateCartItemQuantityUseCase(
        userId: userId,
        itemId: itemId,
        quantity: quantity,
      );
      _clearError();
      return true;
    } catch (e) {
      _setError('Failed to update quantity: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Clear entire cart
  Future<bool> clearCart(String userId) async {
    _setLoading(true);
    _clearError();

    try {
      _cart = await _clearCartUseCase(userId);
      _clearError();
      return true;
    } catch (e) {
      _setError('Failed to clear cart: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Clear cart state (when user logs out)
  void clearCartState() {
    _cart = null;
    _clearError();
    notifyListeners();
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
