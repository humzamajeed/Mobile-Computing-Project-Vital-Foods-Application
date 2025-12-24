import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

/// Order Repository Implementation - Data layer
/// Implements OrderRepository interface using Firebase
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Order> createOrder(Order order) async {
    try {
      return await _remoteDataSource.createOrder(order);
    } catch (e) {
      throw Exception('Failed to create order: ${e.toString()}');
    }
  }

  @override
  Future<List<Order>> getUserOrders(String userId) async {
    try {
      return await _remoteDataSource.getUserOrders(userId);
    } catch (e) {
      throw Exception('Failed to get user orders: ${e.toString()}');
    }
  }

  @override
  Future<Order?> getOrderById(String orderId) async {
    try {
      return await _remoteDataSource.getOrderById(orderId);
    } catch (e) {
      throw Exception('Failed to get order by ID: ${e.toString()}');
    }
  }

  @override
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      return await _remoteDataSource.updateOrderStatus(orderId, status);
    } catch (e) {
      throw Exception('Failed to update order status: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      return await _remoteDataSource.deleteOrder(orderId);
    } catch (e) {
      throw Exception('Failed to delete order: ${e.toString()}');
    }
  }
}
