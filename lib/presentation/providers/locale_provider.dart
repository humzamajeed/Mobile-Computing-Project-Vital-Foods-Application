import 'package:flutter/material.dart';
import '../../core/services/locale_service.dart';

/// Locale Provider
/// Manages app locale state
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US');
  bool _isLoading = false;

  Locale get locale => _locale;
  bool get isLoading => _isLoading;

  /// Initialize locale from storage or device
  Future<void> initializeLocale() async {
    _setLoading(true);

    try {
      final savedLocale = await LocaleService.getSavedLocale();
      if (savedLocale != null) {
        _locale = savedLocale;
      } else {
        // Use device locale if available, otherwise default to English
        final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
        final supportedLocales = LocaleService.getSupportedLocales();
        final supportedLanguageCodes = supportedLocales
            .map((l) => l.languageCode)
            .toList();

        if (supportedLanguageCodes.contains(deviceLocale.languageCode)) {
          _locale = deviceLocale;
        } else {
          _locale = const Locale('en', 'US');
        }
      }
    } catch (e) {
      // Default to English on error
      _locale = const Locale('en', 'US');
    } finally {
      _setLoading(false);
    }
  }

  /// Change locale
  Future<void> changeLocale(Locale newLocale) async {
    if (_locale == newLocale) return;

    _setLoading(true);

    try {
      _locale = newLocale;
      await LocaleService.saveLocale(newLocale);
      notifyListeners();
    } catch (e) {
      debugPrint('Error changing locale: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Get supported locales
  List<Locale> getSupportedLocales() {
    return LocaleService.getSupportedLocales();
  }

  /// Get locale display name
  String getLocaleDisplayName(Locale locale) {
    return LocaleService.getLocaleDisplayName(locale);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
