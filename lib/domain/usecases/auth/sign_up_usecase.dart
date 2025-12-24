import '../../entities/auth_result.dart';
import '../../repositories/auth_repository.dart';

/// Sign up use case - Domain layer
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthResult> call({
    required String email,
    required String password,
    required String confirmPassword,
    String? name,
  }) {
    // Validation
    if (email.isEmpty) {
      return Future.value(AuthResult.failure('Email cannot be empty'));
    }

    if (password.isEmpty) {
      return Future.value(AuthResult.failure('Password cannot be empty'));
    }

    if (confirmPassword.isEmpty) {
      return Future.value(AuthResult.failure('Please confirm your password'));
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

    if (password != confirmPassword) {
      return Future.value(AuthResult.failure('Passwords do not match'));
    }

    return repository.signUpWithEmailAndPassword(
      email: email.trim(),
      password: password,
      name: name?.trim(),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
