import '../entities/auth_result.dart';
import '../entities/user.dart';

/// Auth repository interface - Domain layer
/// Defines authentication operations
abstract class AuthRepository {
  /// Sign in with email and password
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<AuthResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  });

  /// Sign out
  Future<void> signOut();

  /// Get current user
  Future<User?> getCurrentUser();

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Send email verification
  Future<void> sendEmailVerification();

  /// Verify email with code
  Future<AuthResult> verifyEmailWithCode(String code);

  /// Delete account
  Future<void> deleteAccount();

  /// Check if user is authenticated
  Stream<bool> get authStateChanges;
}
