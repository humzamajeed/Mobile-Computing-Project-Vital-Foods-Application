import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/usecases/auth/sign_in_usecase.dart';
import '../../domain/usecases/auth/sign_up_usecase.dart';
import '../../domain/usecases/auth/sign_out_usecase.dart';
import '../../domain/usecases/auth/forgot_password_usecase.dart';
import '../../domain/usecases/auth/delete_account_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/storage/shared_preferences_service.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../core/services/database_cleanup_service.dart';

/// Auth provider - Presentation layer
/// Manages authentication state using Provider
class AuthProvider with ChangeNotifier {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final AuthRepository _authRepository;
  final DatabaseCleanupService? _databaseCleanupService;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;
  int _resendTimer = 0;

  AuthProvider({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required AuthRepository authRepository,
    DatabaseCleanupService? databaseCleanupService,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _signOutUseCase = signOutUseCase,
       _forgotPasswordUseCase = forgotPasswordUseCase,
       _deleteAccountUseCase = deleteAccountUseCase,
       _authRepository = authRepository,
       _databaseCleanupService = databaseCleanupService;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get rememberMe => _rememberMe;
  int get resendTimer => _resendTimer;

  /// Sign in
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _signInUseCase(email: email, password: password);

      if (result.isSuccess && result.user != null) {
        _user = result.user;
        _clearError();

        // Debug: Print user role
        debugPrint('AuthProvider - User set with role: ${_user?.role}');
        debugPrint('AuthProvider - User ID: ${_user?.id}');
        debugPrint('AuthProvider - User Email: ${_user?.email}');

        // Save login state and user data
        await _saveUserData(result.user!);

        // Notify listeners to update UI
        notifyListeners();
      } else {
        _setError(result.errorMessage ?? 'Sign in failed');
      }

      return result;
    } catch (e) {
      final error = 'An error occurred: ${e.toString()}';
      _setError(error);
      return AuthResult.failure(error);
    } finally {
      _setLoading(false);
    }
  }

  /// Sign up
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    String? name,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _signUpUseCase(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        name: name,
      );

      if (result.isSuccess && result.user != null) {
        _user = result.user;
        _clearError();

        // Save login state and user data
        await _saveUserData(result.user!);
      } else {
        _setError(result.errorMessage ?? 'Sign up failed');
      }

      return result;
    } catch (e) {
      final error = 'An error occurred: ${e.toString()}';
      _setError(error);
      return AuthResult.failure(error);
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _setLoading(true);
    _clearError();

    try {
      await _signOutUseCase();
      _user = null;
      _clearError();

      // Clear all stored data
      await _clearUserData();

      // Clear all database collections
      if (_databaseCleanupService != null) {
        debugPrint('🧹 Clearing database on logout...');
        await _databaseCleanupService.clearAllCollections();
        debugPrint('✅ Database cleared on logout');
      }
    } catch (e) {
      _setError('Sign out failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Forgot password
  Future<void> forgotPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _forgotPasswordUseCase(email);
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  /// Toggle remember me
  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  /// Start resend timer
  void startResendTimer() {
    _resendTimer = 50;
    notifyListeners();
  }

  /// Decrement resend timer
  void decrementResendTimer() {
    if (_resendTimer > 0) {
      _resendTimer--;
      notifyListeners();
    }
  }

  /// Reset resend timer
  void resetResendTimer() {
    _resendTimer = 0;
    notifyListeners();
  }

  /// Set current user (for initialization)
  void setUser(User? user) {
    _user = user;
    notifyListeners();
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

  /// Save user data to storage
  Future<void> _saveUserData(User user) async {
    // Save to SharedPreferences (non-sensitive data)
    await SharedPreferencesService.setLoginStatus(true);
    await SharedPreferencesService.setUserId(user.id);
    await SharedPreferencesService.setUserEmail(user.email);
    if (user.name != null) {
      await SharedPreferencesService.setUserName(user.name!);
    }

    // Save token to SecureStorage (sensitive data)
    // Get Firebase ID token and save it
    try {
      final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final token = await firebaseUser.getIdToken();
        if (token != null) {
          await SecureStorageService.setAuthToken(token);
        }
      }
    } catch (e) {
      // If token fetch fails, still save login status
      debugPrint('Failed to get auth token: $e');
    }
  }

  /// Clear all user data from storage
  Future<void> _clearUserData() async {
    // Clear SharedPreferences
    await SharedPreferencesService.setLoginStatus(false);
    await SharedPreferencesService.remove('userId');
    await SharedPreferencesService.remove('userEmail');
    await SharedPreferencesService.remove('userName');

    // Clear SecureStorage
    await SecureStorageService.deleteAuthToken();
    await SecureStorageService.deleteRefreshToken();
  }

  /// Load user data from storage (for app initialization)
  Future<void> loadUserFromStorage() async {
    // Don't load from storage - always fetch fresh from Firebase
    // This ensures role is always up-to-date
    _user = null;
    notifyListeners();
  }

  /// Refresh user data from Firestore
  /// Call this after profile updates to get latest user data
  Future<void> refreshUser() async {
    if (_user == null) return;

    try {
      final updatedUser = await _authRepository.getCurrentUser();
      if (updatedUser != null) {
        _user = updatedUser;
        await _saveUserData(updatedUser);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to refresh user: $e');
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    _setLoading(true);
    _clearError();

    try {
      await _deleteAccountUseCase();
      _user = null;
      _clearError();

      // Clear all stored data
      await _clearUserData();
    } catch (e) {
      _setError('Delete account failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
}
