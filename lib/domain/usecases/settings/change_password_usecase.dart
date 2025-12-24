import '../../repositories/settings_repository.dart';

/// Change password use case - Domain layer
class ChangePasswordUseCase {
  final SettingsRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    // Validation
    if (currentPassword.isEmpty) {
      throw Exception('Current password cannot be empty');
    }

    if (newPassword.isEmpty) {
      throw Exception('New password cannot be empty');
    }

    if (newPassword.length < 6) {
      throw Exception('New password must be at least 6 characters');
    }

    if (newPassword != confirmPassword) {
      throw Exception('New passwords do not match');
    }

    if (currentPassword == newPassword) {
      throw Exception('New password must be different from current password');
    }

    return repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
