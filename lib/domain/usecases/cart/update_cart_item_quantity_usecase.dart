import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

/// Update Cart Item Quantity Use Case
/// Updates the quantity of an item in the user's cart
class UpdateCartItemQuantityUseCase {
  final CartRepository _cartRepository;

  UpdateCartItemQuantityUseCase(this._cartRepository);

  Future<Cart> call({
    required String userId,
    required String itemId,
    required int quantity,
  }) async {
    if (itemId.isEmpty) {
      throw Exception('Item ID cannot be empty');
    }
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than 0');
    }

    return await _cartRepository.updateCartItemQuantity(
      userId: userId,
      itemId: itemId,
      quantity: quantity,
    );
  }
}
