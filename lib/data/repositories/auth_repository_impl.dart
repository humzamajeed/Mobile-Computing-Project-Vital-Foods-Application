import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Auth repository implementation - Data layer
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }

  @override
  Future<AuthResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final user = await _remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await _remoteDataSource.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> sendEmailVerification() async {
    await _remoteDataSource.sendEmailVerification();
  }

  @override
  Future<AuthResult> verifyEmailWithCode(String code) async {
    try {
      final user = await _remoteDataSource.verifyEmailWithCode(code);
      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    await _remoteDataSource.deleteAccount();
  }

  @override
  Stream<bool> get authStateChanges {
    return _remoteDataSource.authStateChanges.map((user) => user != null);
  }
}
