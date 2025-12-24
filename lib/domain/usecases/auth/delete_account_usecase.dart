import '../../repositories/auth_repository.dart';

/// Delete account use case - Domain layer
class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> call() {
    return repository.deleteAccount();
  }
}
