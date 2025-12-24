import '../../repositories/auth_repository.dart';

/// Forgot password use case - Domain layer
class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<void> call(String email) {
    if (email.isEmpty) {
      throw Exception('Email cannot be empty');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Please enter a valid email address');
    }

    return repository.sendPasswordResetEmail(email.trim());
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
