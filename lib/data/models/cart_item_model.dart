import '../../domain/entities/cart_item.dart';

/// Cart Item Model - Data layer
/// Extends CartItem entity with JSON serialization
class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.foodName,
    required super.restaurantName,
    required super.price,
    required super.quantity,
    required super.imageUrl,
    super.size,
    required super.createdAt,
    super.updatedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      foodName: json['foodName'] as String,
      restaurantName: json['restaurantName'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: json['imageUrl'] as String,
      size: json['size'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodName': foodName,
      'restaurantName': restaurantName,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'size': size,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      id: item.id,
      foodName: item.foodName,
      restaurantName: item.restaurantName,
      price: item.price,
      quantity: item.quantity,
      imageUrl: item.imageUrl,
      size: item.size,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }
}
