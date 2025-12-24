import 'package:equatable/equatable.dart';
import 'cart_item.dart';

/// Order entity - Domain layer
/// Represents a user's order
class Order extends Equatable {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalPrice;
  final String status; // 'preparing', 'on_the_way', 'delivered'
  final String? paymentMethod;
  final String? deliveryAddress;
  final String? estimatedTime; // e.g., "20 min"
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
    this.paymentMethod,
    this.deliveryAddress,
    this.estimatedTime,
    required this.createdAt,
    this.updatedAt,
  });

  /// Check if order is ongoing (not delivered)
  bool get isOngoing => status != 'delivered';

  /// Check if order is delivered
  bool get isDelivered => status == 'delivered';

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    totalPrice,
    status,
    paymentMethod,
    deliveryAddress,
    estimatedTime,
    createdAt,
    updatedAt,
  ];

  Order copyWith({
    String? id,
    String? userId,
    List<CartItem>? items,
    double? totalPrice,
    String? status,
    String? paymentMethod,
    String? deliveryAddress,
    String? estimatedTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
