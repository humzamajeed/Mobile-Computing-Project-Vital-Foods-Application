import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

/// Cart Model - Data layer
/// Extends Cart entity with JSON serialization
class CartModel extends Cart {
  const CartModel({
    required super.userId,
    required super.items,
    super.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['userId'] as String,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) {
        if (item is CartItemModel) {
          return item.toJson();
        }
        return CartItemModel.fromEntity(item).toJson();
      }).toList(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      userId: cart.userId,
      items: cart.items,
      updatedAt: cart.updatedAt,
    );
  }
}
