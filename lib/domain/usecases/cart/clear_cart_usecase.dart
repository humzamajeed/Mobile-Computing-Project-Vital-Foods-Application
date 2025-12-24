import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

/// Clear Cart Use Case
/// Clears all items from the user's cart
class ClearCartUseCase {
  final CartRepository _cartRepository;

  ClearCartUseCase(this._cartRepository);

  Future<Cart> call(String userId) async {
    return await _cartRepository.clearCart(userId);
  }
}
