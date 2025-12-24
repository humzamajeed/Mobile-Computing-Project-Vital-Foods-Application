import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/settings.dart' as domain;
import '../models/settings_model.dart';

/// Settings remote data source - Data layer
/// Handles Firebase Firestore operations for settings
class SettingsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  SettingsRemoteDataSource({
    FirebaseFirestore? firestore,
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  /// Get user settings
  Future<domain.Settings> getSettings() async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('settings')
          .doc('preferences')
          .get();

      if (doc.exists) {
        return SettingsModel.fromJson(doc.data()!);
      }

      // Return default settings if not found
      return const domain.Settings();
    } catch (e) {
      throw Exception('Get settings failed: ${e.toString()}');
    }
  }

  /// Update settings
  Future<void> updateSettings(domain.Settings settings) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final settingsModel = SettingsModel.fromDomain(settings);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('settings')
          .doc('preferences')
          .set(settingsModel.toJson());
    } catch (e) {
      throw Exception('Update settings failed: ${e.toString()}');
    }
  }

  /// Update profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? bio,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final updates = <String, dynamic>{
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (name != null) {
        updates['name'] = name;
        // Update Firebase Auth display name
        await user.updateDisplayName(name);
      }

      if (email != null && email != user.email) {
        // Check if email is already verified before updating
        if (!user.emailVerified) {
          throw Exception(
            'Please verify your current email before changing it',
          );
        }

        // Re-authenticate user before changing email (Firebase requirement)
        // Note: This requires the user's current password, which we don't have here
        // For now, we'll update Firestore but skip Firebase Auth email update
        // In a production app, you'd require password confirmation
        updates['email'] = email;

        // Try to update Firebase Auth email using verifyBeforeUpdateEmail (recommended)
        // This sends a verification email to the new address
        try {
          await user.verifyBeforeUpdateEmail(email);
          // Note: Email will be updated after user verifies the new email
          // Firestore is updated immediately, but Firebase Auth email change is pending verification
        } on firebase_auth.FirebaseAuthException catch (e) {
          if (e.code == 'requires-recent-login') {
            throw Exception(
              'Please verify the new email before changing email. Re-authentication required.',
            );
          } else if (e.code == 'email-already-in-use') {
            throw Exception('This email is already in use by another account');
          } else {
            // Still update Firestore even if Firebase Auth update fails
            debugPrint(
              'Warning: Could not update Firebase Auth email: ${e.message}',
            );
          }
        }
      }

      if (phoneNumber != null) {
        updates['phoneNumber'] = phoneNumber;
      }

      if (photoUrl != null) {
        updates['photoUrl'] = photoUrl;
        // Update Firebase Auth photo URL
        await user.updatePhotoURL(photoUrl);
      }

      if (bio != null) {
        updates['bio'] = bio;
      }

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).update(updates);

      // Reload user to get updated data
      await user.reload();
    } catch (e) {
      throw Exception('Update profile failed: ${e.toString()}');
    }
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Re-authenticate user
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
    } on firebase_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw Exception('Current password is incorrect');
        case 'weak-password':
          throw Exception('New password is too weak');
        default:
          throw Exception('Change password failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Change password failed: ${e.toString()}');
    }
  }
}
