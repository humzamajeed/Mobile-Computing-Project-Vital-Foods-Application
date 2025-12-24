import 'package:equatable/equatable.dart';

/// Review entity - Domain layer
/// Represents a review in the business logic
class Review extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String? userImageUrl;
  final String chefId; // Seller/Chef ID
  final String? chefName; // Chef's name
  final String? chefImageUrl; // Chef's profile image
  final String? orderId; // Optional: link to order
  final String? foodName; // Optional: food item reviewed
  final double rating; // 1-5 stars
  final String title;
  final String? reviewText;
  final List<String>? tags; // e.g., ['Delicious', 'Fast Delivery']
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    this.userImageUrl,
    required this.chefId,
    this.chefName,
    this.chefImageUrl,
    this.orderId,
    this.foodName,
    required this.rating,
    required this.title,
    this.reviewText,
    this.tags,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    userName,
    userImageUrl,
    chefId,
    chefName,
    chefImageUrl,
    orderId,
    foodName,
    rating,
    title,
    reviewText,
    tags,
    createdAt,
    updatedAt,
  ];

  Review copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userImageUrl,
    String? chefId,
    String? chefName,
    String? chefImageUrl,
    String? orderId,
    String? foodName,
    double? rating,
    String? title,
    String? reviewText,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      chefId: chefId ?? this.chefId,
      chefName: chefName ?? this.chefName,
      chefImageUrl: chefImageUrl ?? this.chefImageUrl,
      orderId: orderId ?? this.orderId,
      foodName: foodName ?? this.foodName,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      reviewText: reviewText ?? this.reviewText,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
