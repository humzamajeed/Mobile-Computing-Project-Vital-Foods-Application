import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review.dart' as domain;

/// Review model - Data layer
/// Extends Review entity with JSON serialization
class ReviewModel extends domain.Review {
  const ReviewModel({
    required super.id,
    required super.userId,
    required super.userName,
    super.userImageUrl,
    required super.chefId,
    super.chefName,
    super.chefImageUrl,
    super.orderId,
    super.foodName,
    required super.rating,
    required super.title,
    super.reviewText,
    super.tags,
    required super.createdAt,
    super.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String?,
      chefId: json['chefId'] as String,
      chefName: json['chefName'] as String?,
      chefImageUrl: json['chefImageUrl'] as String?,
      orderId: json['orderId'] as String?,
      foodName: json['foodName'] as String?,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
      reviewText: json['reviewText'] as String?,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : null,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
                ? (json['createdAt'] as Timestamp).toDate()
                : DateTime.parse(json['createdAt'] as String))
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
                ? (json['updatedAt'] as Timestamp).toDate()
                : DateTime.parse(json['updatedAt'] as String))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
      'chefId': chefId,
      'chefName': chefName,
      'chefImageUrl': chefImageUrl,
      'orderId': orderId,
      'foodName': foodName,
      'rating': rating,
      'title': title,
      'reviewText': reviewText,
      'tags': tags,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory ReviewModel.fromEntity(domain.Review review) {
    return ReviewModel(
      id: review.id,
      userId: review.userId,
      userName: review.userName,
      userImageUrl: review.userImageUrl,
      chefId: review.chefId,
      chefName: review.chefName,
      chefImageUrl: review.chefImageUrl,
      orderId: review.orderId,
      foodName: review.foodName,
      rating: review.rating,
      title: review.title,
      reviewText: review.reviewText,
      tags: review.tags,
      createdAt: review.createdAt,
      updatedAt: review.updatedAt,
    );
  }
}
