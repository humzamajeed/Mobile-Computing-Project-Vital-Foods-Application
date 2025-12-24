import '../../domain/entities/favorite_item.dart';

/// Favorite Item model - Data layer
/// Extends FavoriteItem entity with JSON serialization
class FavoriteItemModel extends FavoriteItem {
  const FavoriteItemModel({
    required super.id,
    required super.foodName,
    super.restaurantName,
    required super.price,
    required super.imageUrl,
    required super.createdAt,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'] as String,
      foodName: json['foodName'] as String,
      restaurantName: json['restaurantName'] as String?,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodName': foodName,
      'restaurantName': restaurantName,
      'price': price,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
