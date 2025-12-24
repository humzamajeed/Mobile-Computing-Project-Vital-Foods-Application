import '../../entities/order.dart';
import '../../repositories/order_repository.dart';

/// Get User Orders Use Case
/// Retrieves all orders for a user
class GetUserOrdersUseCase {
  final OrderRepository _orderRepository;

  GetUserOrdersUseCase(this._orderRepository);

  Future<List<Order>> call(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID cannot be empty');
    }

    return await _orderRepository.getUserOrders(userId);
  }
}
