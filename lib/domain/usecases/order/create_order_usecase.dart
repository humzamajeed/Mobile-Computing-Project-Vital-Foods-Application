import '../../entities/order.dart';
import '../../repositories/order_repository.dart';

/// Create Order Use Case
/// Creates a new order
class CreateOrderUseCase {
  final OrderRepository _orderRepository;

  CreateOrderUseCase(this._orderRepository);

  Future<Order> call(Order order) async {
    // Validate order
    if (order.items.isEmpty) {
      throw Exception('Cannot create order with empty items');
    }

    if (order.totalPrice <= 0) {
      throw Exception('Order total price must be greater than 0');
    }

    if (order.userId.isEmpty) {
      throw Exception('User ID cannot be empty');
    }

    return await _orderRepository.createOrder(order);
  }
}
