import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_datasource.dart';

/// Settings repository implementation - Data layer
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Settings> getSettings() async {
    return await _remoteDataSource.getSettings();
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    await _remoteDataSource.updateSettings(settings);
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? bio,
  }) async {
    await _remoteDataSource.updateProfile(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      bio: bio,
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
