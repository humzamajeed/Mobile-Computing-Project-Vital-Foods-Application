import 'package:equatable/equatable.dart';

/// Settings entity - Domain layer
/// Represents user settings/preferences
class Settings extends Equatable {
  final bool notificationsEnabled;
  final bool locationEnabled;
  final bool darkModeEnabled;
  final String language;

  const Settings({
    this.notificationsEnabled = true,
    this.locationEnabled = true,
    this.darkModeEnabled = false,
    this.language = 'English',
  });

  @override
  List<Object?> get props => [
    notificationsEnabled,
    locationEnabled,
    darkModeEnabled,
    language,
  ];

  Settings copyWith({
    bool? notificationsEnabled,
    bool? locationEnabled,
    bool? darkModeEnabled,
    String? language,
  }) {
    return Settings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      language: language ?? this.language,
    );
  }
}
