import 'package:equatable/equatable.dart';

/// Favorite Item entity - Domain layer
/// Represents a favorite food item
class FavoriteItem extends Equatable {
  final String id;
  final String foodName;
  final String? restaurantName;
  final int price;
  final String imageUrl;
  final DateTime createdAt;

  const FavoriteItem({
    required this.id,
    required this.foodName,
    this.restaurantName,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    foodName,
    restaurantName,
    price,
    imageUrl,
    createdAt,
  ];
}
