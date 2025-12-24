import '../../entities/auth_result.dart';
import '../../repositories/auth_repository.dart';

/// Sign in use case - Domain layer
class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<AuthResult> call({required String email, required String password}) {
    // Validation
    if (email.isEmpty) {
      return Future.value(AuthResult.failure('Email cannot be empty'));
    }

    if (password.isEmpty) {
      return Future.value(AuthResult.failure('Password cannot be empty'));
    }

    if (!_isValidEmail(email)) {
      return Future.value(
        AuthResult.failure('Please enter a valid email address'),
      );
    }

    if (password.length < 6) {
      return Future.value(
        AuthResult.failure('Password must be at least 6 characters'),
      );
    }

    return repository.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
