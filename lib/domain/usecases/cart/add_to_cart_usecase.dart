import '../../entities/cart.dart';
import '../../entities/cart_item.dart';
import '../../repositories/cart_repository.dart';

/// Add To Cart Use Case
/// Adds an item to the user's cart
class AddToCartUseCase {
  final CartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);

  Future<Cart> call({required String userId, required CartItem item}) async {
    // Validate item
    if (item.quantity <= 0) {
      throw Exception('Quantity must be greater than 0');
    }
    if (item.price < 0) {
      throw Exception('Price cannot be negative');
    }
    if (item.foodName.isEmpty) {
      throw Exception('Food name cannot be empty');
    }

    return await _cartRepository.addToCart(userId: userId, item: item);
  }
}
