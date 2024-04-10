import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  ResultFuture<SettingsEntity> getSettings(
      {required SettingsParams params}) async {
    try {
      SettingsModel localData =
          await localDataSource.getSettings(params: params);

      return Right(localData);
    } catch (error) {
      return Left(
        StorageFailure(
            statusCode: 400, message: 'Exception: ${error.toString()}'),
      );
    }
  }

  @override
  ResultFutureVoid setSettings({
    required SettingsParams params,
    required SettingsEntity settings,
  }) async {
    try {
      await localDataSource.setSettings(
          params: params, settings: SettingsModel.fromEntity(settings));
      return const Right(null);
    } catch (error) {
      return Left(
        StorageFailure(
            statusCode: 400, message: 'Exception: ${error.toString()}'),
      );
    }
  }
}
