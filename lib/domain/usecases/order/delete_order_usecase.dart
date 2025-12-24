import '../../repositories/order_repository.dart';

/// Delete Order Use Case
/// Deletes an order from the database
class DeleteOrderUseCase {
  final OrderRepository _orderRepository;

  DeleteOrderUseCase(this._orderRepository);

  Future<void> call(String orderId) async {
    if (orderId.isEmpty) {
      throw Exception('Order ID cannot be empty');
    }

    return await _orderRepository.deleteOrder(orderId);
  }
}
