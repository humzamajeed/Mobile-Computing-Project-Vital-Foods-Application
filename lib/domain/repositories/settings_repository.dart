import '../entities/settings.dart';

/// Settings repository interface - Domain layer
/// Defines settings operations
abstract class SettingsRepository {
  /// Get user settings
  Future<Settings> getSettings();

  /// Update settings
  Future<void> updateSettings(Settings settings);

  /// Update profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? bio,
  });

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
