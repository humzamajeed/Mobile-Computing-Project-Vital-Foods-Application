import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/order.dart' as domain;
import '../models/order_model.dart';

/// Order Remote Data Source - Data layer
/// Handles Firebase Firestore operations for orders
class OrderRemoteDataSource {
  final FirebaseFirestore _firestore;

  OrderRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collection = 'orders';

  /// Create a new order in Firestore
  Future<domain.Order> createOrder(domain.Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final orderRef = _firestore.collection(_collection).doc();

      // Set the order ID to match the document ID
      final orderData = orderModel.toJson();
      orderData['id'] = orderRef.id;

      // Debug: Print order data before saving
      debugPrint('📦 Creating order in Firestore:');
      debugPrint('   - Collection: $_collection');
      debugPrint('   - Document ID: ${orderRef.id}');
      debugPrint('   - User ID: ${order.userId}');
      debugPrint('   - Total Price: ${order.totalPrice}');
      debugPrint('   - Items count: ${order.items.length}');

      await orderRef.set(orderData);

      // Verify the order was saved
      final savedDoc = await orderRef.get();
      if (!savedDoc.exists) {
        throw Exception('Order was not saved to Firestore');
      }

      debugPrint(
        '✅ Order successfully saved to Firestore with ID: ${orderRef.id}',
      );

      // Return the created order with the correct ID
      return OrderModel.fromJson({'id': orderRef.id, ...orderData});
    } catch (e) {
      debugPrint('❌ Error creating order: $e');
      throw Exception('Failed to create order: ${e.toString()}');
    }
  }

  /// Get all orders for a user
  /// Returns list of orders ordered by createdAt DESC
  Future<List<domain.Order>> getUserOrders(String userId) async {
    try {
      // Query by userId only (no orderBy to avoid index requirement)
      // We'll sort in memory instead
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();

      final orders = querySnapshot.docs.map((doc) {
        return OrderModel.fromJson({'id': doc.id, ...doc.data()});
      }).toList();

      // Sort by createdAt descending in memory
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return orders;
    } catch (e) {
      throw Exception('Failed to get user orders: ${e.toString()}');
    }
  }

  /// Get order by ID
  Future<domain.Order?> getOrderById(String orderId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(orderId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      return OrderModel.fromJson({'id': doc.id, ...doc.data()!});
    } catch (e) {
      throw Exception('Failed to get order by ID: ${e.toString()}');
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestore.collection(_collection).doc(orderId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update order status: ${e.toString()}');
    }
  }

  /// Delete an order
  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection(_collection).doc(orderId).delete();
    } catch (e) {
      throw Exception('Failed to delete order: ${e.toString()}');
    }
  }
}
