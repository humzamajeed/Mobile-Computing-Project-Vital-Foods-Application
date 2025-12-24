import 'package:equatable/equatable.dart';

/// User entity - Domain layer
/// Represents a user in the business logic
class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? phoneNumber;
  final String? photoUrl;
  final String? bio;
  final bool emailVerified;
  final String role; // 'user' or 'chef'
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.phoneNumber,
    this.photoUrl,
    this.bio,
    this.emailVerified = false,
    this.role = 'user', // Default to 'user'
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    phoneNumber,
    photoUrl,
    bio,
    emailVerified,
    role,
    createdAt,
    updatedAt,
  ];

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    String? bio,
    bool? emailVerified,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      emailVerified: emailVerified ?? this.emailVerified,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
