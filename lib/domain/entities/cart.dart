import 'package:equatable/equatable.dart';
import 'cart_item.dart';

/// Cart entity - Domain layer
/// Represents a user's shopping cart
class Cart extends Equatable {
  final String userId;
  final List<CartItem> items;
  final DateTime? updatedAt;

  const Cart({required this.userId, required this.items, this.updatedAt});

  /// Calculate total price of all items in cart
  double get totalPrice {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Get total number of items in cart
  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;

  /// Check if cart is not empty
  bool get isNotEmpty => items.isNotEmpty;

  @override
  List<Object?> get props => [userId, items, updatedAt];

  Cart copyWith({String? userId, List<CartItem>? items, DateTime? updatedAt}) {
    return Cart(
      userId: userId ?? this.userId,
      items: items ?? this.items,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
