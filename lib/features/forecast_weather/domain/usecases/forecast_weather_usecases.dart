import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/forecast_weather_entity.dart';
import '../repositories/forecast_weather_repository.dart';

class GetForecastWeather {
  final ForecastWeatherRepository repository;

  const GetForecastWeather(this.repository);

  ResultFuture<List<ForecastWeatherEntity>> call({
    required ForecastWeatherParams params,
  }) async {
    return await repository.getForecastWeather(params: params);
  }
}
