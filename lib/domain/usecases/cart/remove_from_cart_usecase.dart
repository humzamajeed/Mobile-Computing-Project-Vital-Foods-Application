import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

/// Remove From Cart Use Case
/// Removes an item from the user's cart
class RemoveFromCartUseCase {
  final CartRepository _cartRepository;

  RemoveFromCartUseCase(this._cartRepository);

  Future<Cart> call({required String userId, required String itemId}) async {
    if (itemId.isEmpty) {
      throw Exception('Item ID cannot be empty');
    }

    return await _cartRepository.removeFromCart(userId: userId, itemId: itemId);
  }
}
