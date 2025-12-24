import 'package:flutter/foundation.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/cart.dart';
import '../../domain/usecases/order/create_order_usecase.dart';
import '../../domain/usecases/order/get_user_orders_usecase.dart';
import '../../domain/usecases/order/get_order_by_id_usecase.dart';
import '../../domain/usecases/order/update_order_status_usecase.dart';
import '../../domain/usecases/order/delete_order_usecase.dart';

/// Order Provider - Presentation layer
/// Manages order state using Provider
class OrderProvider with ChangeNotifier {
  final CreateOrderUseCase _createOrderUseCase;
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  final GetOrderByIdUseCase _getOrderByIdUseCase;
  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  final DeleteOrderUseCase _deleteOrderUseCase;

  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  OrderProvider({
    required CreateOrderUseCase createOrderUseCase,
    required GetUserOrdersUseCase getUserOrdersUseCase,
    required GetOrderByIdUseCase getOrderByIdUseCase,
    required UpdateOrderStatusUseCase updateOrderStatusUseCase,
    required DeleteOrderUseCase deleteOrderUseCase,
  }) : _createOrderUseCase = createOrderUseCase,
       _getUserOrdersUseCase = getUserOrdersUseCase,
       _getOrderByIdUseCase = getOrderByIdUseCase,
       _updateOrderStatusUseCase = updateOrderStatusUseCase,
       _deleteOrderUseCase = deleteOrderUseCase;

  // Getters
  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Order> get ongoingOrders =>
      _orders.where((order) => order.isOngoing).toList();
  List<Order> get orderHistory =>
      _orders.where((order) => order.isDelivered).toList();

  /// Create order from cart
  Future<Order?> createOrder({
    required String userId,
    required Cart cart,
    String? paymentMethod,
    String? deliveryAddress,
    String? estimatedTime,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      if (cart.items.isEmpty) {
        throw Exception('Cannot create order with empty cart');
      }

      final order = Order(
        id: '', // Will be set by Firestore
        userId: userId,
        items: cart.items,
        totalPrice: cart.totalPrice,
        status: 'preparing',
        paymentMethod: paymentMethod,
        deliveryAddress: deliveryAddress,
        estimatedTime: estimatedTime ?? '20 min',
        createdAt: DateTime.now(),
      );

      final createdOrder = await _createOrderUseCase(order);

      // Add to local list
      _orders.insert(0, createdOrder);
      _clearError();
      notifyListeners();

      return createdOrder;
    } catch (e) {
      _setError('Failed to create order: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  /// Load all orders for user
  Future<void> loadUserOrders(String userId) async {
    _setLoading(true);
    _clearError();

    try {
      _orders = await _getUserOrdersUseCase(userId);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load orders: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    _setLoading(true);
    _clearError();

    try {
      final order = await _getOrderByIdUseCase(orderId);
      _clearError();
      return order;
    } catch (e) {
      _setError('Failed to get order: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  /// Update order status
  Future<bool> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _updateOrderStatusUseCase(orderId: orderId, status: status);

      // Update local order
      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update order status: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Delete order
  Future<bool> deleteOrder(String orderId) async {
    _setLoading(true);
    _clearError();

    try {
      await _deleteOrderUseCase(orderId);

      // Remove from local list
      _orders.removeWhere((order) => order.id == orderId);

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to delete order: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Clear order state (when user logs out)
  void clearOrderState() {
    _orders = [];
    _clearError();
    notifyListeners();
  }

  // Private helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
