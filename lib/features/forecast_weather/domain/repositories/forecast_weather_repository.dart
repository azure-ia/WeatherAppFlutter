import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/forecast_weather_entity.dart';

abstract class ForecastWeatherRepository {
  ResultFuture<List<ForecastWeatherEntity>> getForecastWeather({
    required ForecastWeatherParams params,
  });
}
