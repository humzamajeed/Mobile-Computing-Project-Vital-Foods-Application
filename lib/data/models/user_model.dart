import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';

/// User model - Data layer
/// Extends User entity with JSON serialization
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    super.phoneNumber,
    super.photoUrl,
    super.bio,
    super.emailVerified,
    super.role,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Debug: Print raw role value
    debugPrint('🔍 UserModel.fromJson - Raw role value: ${json['role']}');
    debugPrint(
      '🔍 UserModel.fromJson - Role type: ${json['role'].runtimeType}',
    );

    // Safely extract role - handle different types
    String roleValue = 'user'; // Default
    if (json['role'] != null) {
      if (json['role'] is String) {
        roleValue = json['role'] as String;
      } else {
        // Convert to string if it's not already
        roleValue = json['role'].toString();
      }
    }

    debugPrint('🔍 UserModel.fromJson - Final role value: "$roleValue"');

    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
      role: roleValue, // Use the safely extracted role
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is String
                ? DateTime.parse(json['createdAt'] as String)
                : (json['createdAt'] as dynamic).toDate())
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is String
                ? DateTime.parse(json['updatedAt'] as String)
                : (json['updatedAt'] as dynamic).toDate())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'bio': bio,
      'emailVerified': emailVerified,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromFirebaseUser({
    required String id,
    required String email,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    bool emailVerified = false,
    String role = 'user',
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      emailVerified: emailVerified,
      role: role,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
