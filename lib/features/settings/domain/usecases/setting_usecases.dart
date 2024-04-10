import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettings {
  final SettingsRepository repository;

  const GetSettings(this.repository);

  ResultFuture<SettingsEntity> call({
    required SettingsParams params,
  }) async {
    return await repository.getSettings(params: params);
  }
}

class SetSettings {
  final SettingsRepository repository;

  const SetSettings(this.repository);

  ResultFutureVoid call({
    required SettingsParams params,
    required SettingsEntity settings,
  }) async {
    return await repository.setSettings(
      params: params,
      settings: settings,
    );
  }
}
