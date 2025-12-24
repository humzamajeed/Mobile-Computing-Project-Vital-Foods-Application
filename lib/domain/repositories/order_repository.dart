import '../entities/order.dart';

/// Order Repository interface - Domain layer
/// Defines the contract for order operations
abstract class OrderRepository {
  /// Create a new order
  Future<Order> createOrder(Order order);

  /// Get all orders for a user
  /// Returns list of orders ordered by createdAt DESC
  Future<List<Order>> getUserOrders(String userId);

  /// Get order by ID
  Future<Order?> getOrderById(String orderId);

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String status);

  /// Delete an order
  Future<void> deleteOrder(String orderId);
}
