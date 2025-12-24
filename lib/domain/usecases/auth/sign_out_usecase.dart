import '../../repositories/auth_repository.dart';

/// Sign out use case - Domain layer
class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
