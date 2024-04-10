import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/params/params.dart';
import '../models/forecast_weather_local_model.dart';
import '../models/forecast_weather_remote_model.dart';

abstract class ForecastWeatherLocalDataSource {
  Future<List<ForecastWeatherModel>> getForecastWeather(
      {required ForecastWeatherParams params});
  Future<void> setForecastWeather(
      {required List<ForecastWeatherModel> weatherForecast});
}

class ForecastWeatherLocalDataSourceImpl
    implements ForecastWeatherLocalDataSource {
  final Box<List> _box;
  static const _key = 'forecast';

  ForecastWeatherLocalDataSourceImpl(this._box);

  @override
  Future<List<ForecastWeatherModel>> getForecastWeather(
      {required ForecastWeatherParams params}) async {
    try {
      final weatherCache =
          _box.get(_key, defaultValue: <ForecastWeatherModelLoc>[]);
      if (weatherCache == null ||
          weatherCache.isEmpty ||
          weatherCache[0].coordLat != params.coordLat ||
          weatherCache[0].coordLon != params.coordLon ||
          weatherCache[0].units != params.units.name) {
        await _box.delete(_key);
        throw CacheException(400, 'Cache is empty');
      } else {
        return weatherCache
            .map((item) => (item as ForecastWeatherModelLoc).toModel())
            .toList();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setForecastWeather(
      {required List<ForecastWeatherModel> weatherForecast}) async {
    try {
      final weatherCache = weatherForecast
          .map((item) => ForecastWeatherModelLoc.fromModel(item))
          .toList();
      await _box.put(_key, weatherCache);
    } catch (error) {
      rethrow;
    }
  }
}
