import '../../repositories/order_repository.dart';

/// Update Order Status Use Case
/// Updates the status of an order
class UpdateOrderStatusUseCase {
  final OrderRepository _orderRepository;

  UpdateOrderStatusUseCase(this._orderRepository);

  Future<void> call({required String orderId, required String status}) async {
    if (orderId.isEmpty) {
      throw Exception('Order ID cannot be empty');
    }

    // Validate status
    final validStatuses = ['preparing', 'on_the_way', 'delivered'];
    if (!validStatuses.contains(status)) {
      throw Exception('Invalid order status: $status');
    }

    return await _orderRepository.updateOrderStatus(orderId, status);
  }
}
