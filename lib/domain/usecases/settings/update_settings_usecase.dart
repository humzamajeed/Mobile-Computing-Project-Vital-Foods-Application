import '../../entities/settings.dart';
import '../../repositories/settings_repository.dart';

/// Update settings use case - Domain layer
class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<void> call(Settings settings) {
    return repository.updateSettings(settings);
  }
}
