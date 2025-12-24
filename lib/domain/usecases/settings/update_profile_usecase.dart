import '../../repositories/settings_repository.dart';

/// Update profile use case - Domain layer
class UpdateProfileUseCase {
  final SettingsRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call({
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? bio,
  }) {
    // Validation
    if (name != null && name.trim().isEmpty) {
      throw Exception('Name cannot be empty');
    }

    if (email != null && email.trim().isEmpty) {
      throw Exception('Email cannot be empty');
    }

    if (email != null && !email.contains('@')) {
      throw Exception('Invalid email format');
    }

    if (phoneNumber != null && phoneNumber.trim().isEmpty) {
      throw Exception('Phone number cannot be empty');
    }

    return repository.updateProfile(
      name: name?.trim(),
      email: email?.trim(),
      phoneNumber: phoneNumber?.trim(),
      photoUrl: photoUrl,
      bio: bio?.trim(),
    );
  }
}
