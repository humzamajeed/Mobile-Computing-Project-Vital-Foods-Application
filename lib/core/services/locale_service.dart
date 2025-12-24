import 'package:flutter/material.dart';
import '../storage/shared_preferences_service.dart';

/// Locale Service
/// Manages app locale and language preferences
class LocaleService {
  static const String _localeKey = 'app_locale';

  /// Get saved locale from storage
  static Future<Locale?> getSavedLocale() async {
    final localeCode = SharedPreferencesService.getString(_localeKey);
    if (localeCode == null || localeCode.isEmpty) {
      return null; // Use device locale
    }

    // Parse locale code (e.g., "en_US" or "fr")
    final parts = localeCode.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }

  /// Save locale to storage
  static Future<void> saveLocale(Locale locale) async {
    final localeCode = locale.countryCode != null
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
    await SharedPreferencesService.setString(_localeKey, localeCode);
  }

  /// Get supported locales
  static List<Locale> getSupportedLocales() {
    return const [
      Locale('en', 'US'), // English
      Locale('fr', 'FR'), // French
      Locale('ar', 'SA'), // Arabic
    ];
  }

  /// Get locale display name
  static String getLocaleDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'ar':
        return 'العربية';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
