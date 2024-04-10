import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/forecast_weather_entity.dart';
import '../../domain/repositories/forecast_weather_repository.dart';
import '../datasources/forecast_weather_local_data_source.dart';
import '../datasources/forecast_weather_remote_data_source.dart';
import '../models/forecast_weather_remote_model.dart';

class ForecastWeatherRepositoryImpl implements ForecastWeatherRepository {
  final ForecastWeatherRemoteDataSource remoteDataSource;
  final ForecastWeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ForecastWeatherRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  ResultFuture<List<ForecastWeatherEntity>> getForecastWeather(
      {required ForecastWeatherParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<ForecastWeatherModel> remoteData =
            await remoteDataSource.getForecastWeather(params: params);

        await localDataSource.setForecastWeather(weatherForecast: remoteData);

        return Right(
            remoteData.map((item) => item as ForecastWeatherEntity).toList());
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
            await localDataSource.getForecastWeather(params: params);
        return Right(
            localData.map((item) => item as ForecastWeatherEntity).toList());
      } catch (error) {
        return Left(
          CacheFailure(message: 'No internet connection. ${error.toString()}'),
        );
      }
    }
  }
}
