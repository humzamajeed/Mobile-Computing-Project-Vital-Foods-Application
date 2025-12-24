import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/order.dart' as domain;
import 'cart_item_model.dart';

/// Order Model - Data layer
/// Extends Order entity with JSON serialization
class OrderModel extends domain.Order {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalPrice,
    required super.status,
    super.paymentMethod,
    super.deliveryAddress,
    super.estimatedTime,
    required super.createdAt,
    super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      estimatedTime: json['estimatedTime'] as String?,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
                ? (json['createdAt'] as Timestamp).toDate()
                : (json['createdAt'] is String
                      ? DateTime.parse(json['createdAt'] as String)
                      : DateTime.now()))
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
                ? (json['updatedAt'] as Timestamp).toDate()
                : (json['updatedAt'] is String
                      ? DateTime.parse(json['updatedAt'] as String)
                      : null))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) {
        if (item is CartItemModel) {
          return item.toJson();
        }
        return CartItemModel.fromEntity(item).toJson();
      }).toList(),
      'totalPrice': totalPrice,
      'status': status,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'estimatedTime': estimatedTime,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory OrderModel.fromEntity(domain.Order order) {
    return OrderModel(
      id: order.id,
      userId: order.userId,
      items: order.items,
      totalPrice: order.totalPrice,
      status: order.status,
      paymentMethod: order.paymentMethod,
      deliveryAddress: order.deliveryAddress,
      estimatedTime: order.estimatedTime,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
    );
  }
}
