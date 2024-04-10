import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/settings_entity.dart';

abstract class SettingsRepository {
  ResultFuture<SettingsEntity> getSettings({
    required SettingsParams params,
  });
  ResultFutureVoid setSettings({
    required SettingsParams params,
    required SettingsEntity settings,
  });
}
