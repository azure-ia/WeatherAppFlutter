import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/current_weather_entity.dart';
import '../repositories/current_weather_repository.dart';

class GetCurrentWeather {
  final CurrentWeatherRepository repository;

  const GetCurrentWeather(this.repository);

  ResultFuture<CurrentWeatherEntity> call({
    required CurrentWeatherParams params,
  }) async {
    return await repository.getCurrentWeather(params: params);
  }
}
