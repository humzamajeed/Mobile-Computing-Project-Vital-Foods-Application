import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

/// Get Cart Use Case
/// Retrieves the user's cart
class GetCartUseCase {
  final CartRepository _cartRepository;

  GetCartUseCase(this._cartRepository);

  Future<Cart> call(String userId) async {
    return await _cartRepository.getCart(userId);
  }
}
