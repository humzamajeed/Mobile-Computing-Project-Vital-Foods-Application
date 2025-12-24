import '../../entities/order.dart';
import '../../repositories/order_repository.dart';

/// Get Order By ID Use Case
/// Retrieves a specific order by its ID
class GetOrderByIdUseCase {
  final OrderRepository _orderRepository;

  GetOrderByIdUseCase(this._orderRepository);

  Future<Order?> call(String orderId) async {
    if (orderId.isEmpty) {
      throw Exception('Order ID cannot be empty');
    }

    return await _orderRepository.getOrderById(orderId);
  }
}
