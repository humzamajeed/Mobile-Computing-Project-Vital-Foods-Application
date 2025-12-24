import '../../entities/settings.dart';
import '../../repositories/settings_repository.dart';

/// Get settings use case - Domain layer
class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Settings> call() {
    return repository.getSettings();
  }
}
