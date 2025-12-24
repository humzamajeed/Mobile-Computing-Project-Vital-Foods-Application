import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure Storage Service
/// Stores sensitive data like tokens, passwords, and API keys encrypted
class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // ==================== Authentication Tokens ====================
  /// Save auth token
  static Future<void> setAuthToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  /// Get auth token
  static Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  /// Delete auth token
  static Future<void> deleteAuthToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // ==================== Refresh Token ====================
  /// Save refresh token
  static Future<void> setRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  /// Get refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  /// Delete refresh token
  static Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }

  // ==================== User Credentials ====================
  /// Save user password (for remember me functionality)
  /// Note: Only save if user explicitly opts in
  static Future<void> setUserPassword(String password) async {
    await _storage.write(key: 'user_password', value: password);
  }

  /// Get user password
  static Future<String?> getUserPassword() async {
    return await _storage.read(key: 'user_password');
  }

  /// Delete user password
  static Future<void> deleteUserPassword() async {
    await _storage.delete(key: 'user_password');
  }

  // ==================== API Keys ====================
  /// Save API key
  static Future<void> setApiKey(String apiKey) async {
    await _storage.write(key: 'api_key', value: apiKey);
  }

  /// Get API key
  static Future<String?> getApiKey() async {
    return await _storage.read(key: 'api_key');
  }

  /// Delete API key
  static Future<void> deleteApiKey() async {
    await _storage.delete(key: 'api_key');
  }

  // ==================== Session Data ====================
  /// Save session ID
  static Future<void> setSessionId(String sessionId) async {
    await _storage.write(key: 'session_id', value: sessionId);
  }

  /// Get session ID
  static Future<String?> getSessionId() async {
    return await _storage.read(key: 'session_id');
  }

  /// Delete session ID
  static Future<void> deleteSessionId() async {
    await _storage.delete(key: 'session_id');
  }

  // ==================== Payment Cards ====================
  /// Save payment card data (encrypted)
  /// Note: Only save last 4 digits and card type, never full card number
  static Future<void> setPaymentCardData(String cardData) async {
    await _storage.write(key: 'payment_card_data', value: cardData);
  }

  /// Get payment card data
  static Future<String?> getPaymentCardData() async {
    return await _storage.read(key: 'payment_card_data');
  }

  /// Delete payment card data
  static Future<void> deletePaymentCardData() async {
    await _storage.delete(key: 'payment_card_data');
  }

  // ==================== Generic Methods ====================
  /// Write a value
  static Future<void> write({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a key
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all data
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Check if key exists
  static Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  /// Read all values
  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
