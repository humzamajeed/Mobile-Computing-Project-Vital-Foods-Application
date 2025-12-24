import '../../domain/entities/settings.dart';

/// Settings model - Data layer
/// Extends Settings entity with JSON serialization
class SettingsModel extends Settings {
  const SettingsModel({
    super.notificationsEnabled = true,
    super.locationEnabled = true,
    super.darkModeEnabled = false,
    super.language = 'English',
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      locationEnabled: json['locationEnabled'] as bool? ?? true,
      darkModeEnabled: json['darkModeEnabled'] as bool? ?? false,
      language: json['language'] as String? ?? 'English',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'locationEnabled': locationEnabled,
      'darkModeEnabled': darkModeEnabled,
      'language': language,
    };
  }

  factory SettingsModel.fromDomain(Settings settings) {
    return SettingsModel(
      notificationsEnabled: settings.notificationsEnabled,
      locationEnabled: settings.locationEnabled,
      darkModeEnabled: settings.darkModeEnabled,
      language: settings.language,
    );
  }
}
