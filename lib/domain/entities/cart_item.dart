import 'package:equatable/equatable.dart';

/// Cart Item entity - Domain layer
/// Represents a cart item in the business logic
class CartItem extends Equatable {
  final String id;
  final String foodName;
  final String restaurantName;
  final double price;
  final int quantity;
  final String imageUrl;
  final String? size; // Optional size (e.g., "14\"", "10\"")
  final DateTime createdAt;
  final DateTime? updatedAt;

  const CartItem({
    required this.id,
    required this.foodName,
    required this.restaurantName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.size,
    required this.createdAt,
    this.updatedAt,
  });

  /// Calculate total price for this item
  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [
    id,
    foodName,
    restaurantName,
    price,
    quantity,
    imageUrl,
    size,
    createdAt,
    updatedAt,
  ];

  CartItem copyWith({
    String? id,
    String? foodName,
    String? restaurantName,
    double? price,
    int? quantity,
    String? imageUrl,
    String? size,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      restaurantName: restaurantName ?? this.restaurantName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
