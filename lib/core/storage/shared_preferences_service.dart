import 'package:shared_preferences/shared_preferences.dart';

/// Shared Preferences Service
/// Stores non-sensitive data like UI preferences, settings, and login status
class SharedPreferencesService {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ==================== Login Status ====================
  /// Save login status
  static Future<bool> setLoginStatus(bool isLoggedIn) async {
    return await instance.setBool('isLoggedIn', isLoggedIn);
  }

  /// Get login status
  static bool getLoginStatus() {
    return instance.getBool('isLoggedIn') ?? false;
  }

  // ==================== Theme Mode ====================
  /// Save theme mode (light/dark)
  static Future<bool> setThemeMode(String mode) async {
    return await instance.setString('themeMode', mode);
  }

  /// Get theme mode
  static String? getThemeMode() {
    return instance.getString('themeMode');
  }

  // ==================== Language ====================
  /// Save language preference
  static Future<bool> setLanguage(String language) async {
    return await instance.setString('language', language);
  }

  /// Get language preference
  static String? getLanguage() {
    return instance.getString('language');
  }

  // ==================== User Settings ====================
  /// Save user ID
  static Future<bool> setUserId(String userId) async {
    return await instance.setString('userId', userId);
  }

  /// Get user ID
  static String? getUserId() {
    return instance.getString('userId');
  }

  /// Save user email
  static Future<bool> setUserEmail(String email) async {
    return await instance.setString('userEmail', email);
  }

  /// Get user email
  static String? getUserEmail() {
    return instance.getString('userEmail');
  }

  /// Save user name
  static Future<bool> setUserName(String name) async {
    return await instance.setString('userName', name);
  }

  /// Get user name
  static String? getUserName() {
    return instance.getString('userName');
  }

  // ==================== Cart Data ====================
  /// Save cart items count
  static Future<bool> setCartItemsCount(int count) async {
    return await instance.setInt('cartItemsCount', count);
  }

  /// Get cart items count
  static int getCartItemsCount() {
    return instance.getInt('cartItemsCount') ?? 0;
  }

  // ==================== Generic Methods ====================
  /// Save string
  static Future<bool> setString(String key, String value) async {
    return await instance.setString(key, value);
  }

  /// Get string
  static String? getString(String key) {
    return instance.getString(key);
  }

  /// Save int
  static Future<bool> setInt(String key, int value) async {
    return await instance.setInt(key, value);
  }

  /// Get int
  static int? getInt(String key) {
    return instance.getInt(key);
  }

  /// Save bool
  static Future<bool> setBool(String key, bool value) async {
    return await instance.setBool(key, value);
  }

  /// Get bool
  static bool? getBool(String key) {
    return instance.getBool(key);
  }

  /// Save double
  static Future<bool> setDouble(String key, double value) async {
    return await instance.setDouble(key, value);
  }

  /// Get double
  static double? getDouble(String key) {
    return instance.getDouble(key);
  }

  /// Remove a key
  static Future<bool> remove(String key) async {
    return await instance.remove(key);
  }

  /// Clear all data
  static Future<bool> clear() async {
    return await instance.clear();
  }

  /// Check if key exists
  static bool containsKey(String key) {
    return instance.containsKey(key);
  }

  /// Get all keys
  static Set<String> getAllKeys() {
    return instance.getKeys();
  }

  // ==================== Offer Page ====================
  /// Mark offer page as shown
  static Future<bool> setOfferPageShown(bool shown) async {
    return await instance.setBool('offerPageShown', shown);
  }

  /// Check if offer page has been shown
  static bool getOfferPageShown() {
    return instance.getBool('offerPageShown') ?? false;
  }

  // ==================== Location Access ====================
  /// Mark location access page as shown
  static Future<bool> setLocationAccessShown(bool shown) async {
    return await instance.setBool('locationAccessShown', shown);
  }

  /// Check if location access page has been shown
  static bool getLocationAccessShown() {
    return instance.getBool('locationAccessShown') ?? false;
  }
}
