import 'package:flutter/foundation.dart';
import '../../domain/entities/settings.dart';
import '../../domain/usecases/settings/get_settings_usecase.dart';
import '../../domain/usecases/settings/update_settings_usecase.dart';
import '../../domain/usecases/settings/update_profile_usecase.dart';
import '../../domain/usecases/settings/change_password_usecase.dart';

/// Settings provider - Presentation layer
/// Manages settings state using Provider
class SettingsProvider with ChangeNotifier {
  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  Settings? _settings;
  bool _isLoading = false;
  String? _errorMessage;

  SettingsProvider({
    required GetSettingsUseCase getSettingsUseCase,
    required UpdateSettingsUseCase updateSettingsUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
  }) : _getSettingsUseCase = getSettingsUseCase,
       _updateSettingsUseCase = updateSettingsUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _changePasswordUseCase = changePasswordUseCase;

  // Getters
  Settings? get settings => _settings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load settings
  Future<void> loadSettings() async {
    _setLoading(true);
    _clearError();

    try {
      _settings = await _getSettingsUseCase();
      _clearError();
    } catch (e) {
      _setError('Failed to load settings: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Update settings
  Future<void> updateSettings(Settings newSettings) async {
    _setLoading(true);
    _clearError();

    try {
      await _updateSettingsUseCase(newSettings);
      _settings = newSettings;
      _clearError();
    } catch (e) {
      _setError('Failed to update settings: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Update notification preference
  Future<void> updateNotifications(bool enabled) async {
    final newSettings = (_settings ?? const Settings()).copyWith(
      notificationsEnabled: enabled,
    );
    await updateSettings(newSettings);
  }

  /// Update location preference
  Future<void> updateLocation(bool enabled) async {
    final newSettings = (_settings ?? const Settings()).copyWith(
      locationEnabled: enabled,
    );
    await updateSettings(newSettings);
  }

  /// Update dark mode preference
  Future<void> updateDarkMode(bool enabled) async {
    final newSettings = (_settings ?? const Settings()).copyWith(
      darkModeEnabled: enabled,
    );
    await updateSettings(newSettings);
  }

  /// Update language
  Future<void> updateLanguage(String language) async {
    final newSettings = (_settings ?? const Settings()).copyWith(
      language: language,
    );
    await updateSettings(newSettings);
  }

  /// Update profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? bio,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _updateProfileUseCase(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        bio: bio,
      );
      _clearError();
    } catch (e) {
      _setError('Failed to update profile: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _changePasswordUseCase(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Clear error
  void clearError() {
    _clearError();
  }

  // Private methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
