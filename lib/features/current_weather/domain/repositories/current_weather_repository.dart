import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/current_weather_entity.dart';

abstract class CurrentWeatherRepository {
  ResultFuture<CurrentWeatherEntity> getCurrentWeather({
    required CurrentWeatherParams params,
  });
}
