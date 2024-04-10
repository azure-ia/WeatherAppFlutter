import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/repositories/current_weather_repository.dart';
import '../datasources/current_weather_local_data_source.dart';
import '../datasources/current_weather_remote_data_source.dart';
import '../models/current_weather_remote_model.dart';

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherRemoteDataSource remoteDataSource;
  final CurrentWeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CurrentWeatherRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  ResultFuture<CurrentWeatherEntity> getCurrentWeather(
      {required CurrentWeatherParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        CurrentWeatherModel remoteData =
            await remoteDataSource.getCurrentWeather(params: params);

        localDataSource.setCurrentWeather(weatherModel: remoteData);

        return Right(remoteData);
      } on APIException catch (apiError) {
        return Left(
          ServerFailure(
              statusCode: apiError.statusCode,
              message: 'Server exception. ${apiError.message} '),
        );
      } catch (error) {
        return Left(
          ServerFailure(message: 'Server exception. ${error.toString()}'),
        );
      }
    } else {
      try {
        final localData =
            await localDataSource.getCurrentWeather(params: params);
        return Right(localData);
      } catch (error) {
        return Left(
          CacheFailure(message: 'No internet connection. ${error.toString()}'),
        );
      }
    }
  }
}
