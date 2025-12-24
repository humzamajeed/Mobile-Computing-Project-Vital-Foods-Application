import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

/// Auth remote data source - Data layer
/// Handles Firebase authentication operations
class AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  /// Sign in with email and password
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('User not found');
      }

      return await _getUserFromFirebase(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  /// Sign up with email and password
  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('User creation failed');
      }

      final user = credential.user!;

      // Update display name if provided
      if (name != null && name.isNotEmpty) {
        await user.updateDisplayName(name);
        await user.reload();
      }

      // Create user document in Firestore
      // Set different default profile images for user vs chef
      final defaultUserImage =
          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=800&q=80';
      final userModel = UserModel.fromFirebaseUser(
        id: user.uid,
        email: user.email!,
        name: name,
        photoUrl: defaultUserImage, // Set default image for new users
        emailVerified: user.emailVerified,
        role: 'user', // Default role for new signups
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());

      return await _getUserFromFirebase(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  /// Get current user
  Future<User?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      return await _getUserFromFirebase(firebaseUser);
    } catch (e) {
      throw Exception('Get current user failed: ${e.toString()}');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Send password reset email failed: ${e.toString()}');
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      await user.sendEmailVerification();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Send email verification failed: ${e.toString()}');
    }
  }

  /// Verify email with code
  Future<User> verifyEmailWithCode(String code) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      // Note: Email verification codes are typically handled via email links
      // This is a placeholder for OTP verification if needed
      await user.reload();
      final updatedUser = _firebaseAuth.currentUser!;

      if (!updatedUser.emailVerified) {
        throw Exception('Email verification failed');
      }

      // Update user document
      await _firestore.collection('users').doc(updatedUser.uid).update({
        'emailVerified': true,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      return await _getUserFromFirebase(updatedUser);
    } catch (e) {
      throw Exception('Email verification failed: ${e.toString()}');
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      // Delete user document from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete Firebase Auth user
      await user.delete();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Delete account failed: ${e.toString()}');
    }
  }

  /// Get auth state changes stream
  Stream<firebase_auth.User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  /// Get user from Firebase and Firestore
  Future<User> _getUserFromFirebase(firebase_auth.User firebaseUser) async {
    try {
      // Try to get user data from Firestore
      final doc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final userJson = {
          ...data,
          'id': firebaseUser.uid,
          'email': firebaseUser.email ?? data['email'],
          'emailVerified': firebaseUser.emailVerified,
        };
        // Debug: Print role from Firestore
        debugPrint('📋 User data from Firestore:');
        debugPrint('   - UID: ${firebaseUser.uid}');
        debugPrint('   - Email: ${userJson['email']}');
        debugPrint('   - Role: ${userJson['role']}');
        debugPrint('   - All data keys: ${data.keys.toList()}');

        final user = UserModel.fromJson(userJson);
        debugPrint('✅ UserModel created with role: ${user.role}');

        // Set default profile image based on role if photoUrl is null or empty
        if (user.photoUrl == null || user.photoUrl!.isEmpty) {
          final defaultImage = user.role == 'chef'
              ? 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?auto=format&fit=crop&w=800&q=80' // Chef image
              : 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=800&q=80'; // User image
          return user.copyWith(photoUrl: defaultImage);
        }

        return user;
      }

      // If not in Firestore, create from Firebase Auth
      final defaultUserImage =
          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=800&q=80';
      return UserModel.fromFirebaseUser(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL ?? defaultUserImage,
        emailVerified: firebaseUser.emailVerified,
        role: 'user', // Default role
      );
    } catch (e) {
      // Fallback to Firebase Auth data only
      final defaultUserImage =
          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=800&q=80';
      return UserModel.fromFirebaseUser(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL ?? defaultUserImage,
        emailVerified: firebaseUser.emailVerified,
        role: 'user', // Default role
      );
    }
  }

  /// Handle Firebase Auth exceptions
  String _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}
