import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/params/params.dart';
import '../models/current_weather_local_model.dart';
import '../models/current_weather_remote_model.dart';

abstract class CurrentWeatherLocalDataSource {
  Future<CurrentWeatherModel> getCurrentWeather(
      {required CurrentWeatherParams params});
  Future<void> setCurrentWeather({required CurrentWeatherModel weatherModel});
}

class CurrentWeatherLocalDataSourceImpl
    implements CurrentWeatherLocalDataSource {
  final Box<CurrentWeatherModelLoc> _box;
  static const _key = 'current';

  CurrentWeatherLocalDataSourceImpl(this._box);

  @override
  Future<CurrentWeatherModel> getCurrentWeather(
      {required CurrentWeatherParams params}) async {
    try {
      final weatherCache = _box.get(_key);
      if (weatherCache == null ||
          weatherCache.coordLat != params.coordLat ||
          weatherCache.coordLon != params.coordLon ||
          weatherCache.units != params.units.name) {
        await _box.delete(_key);
        throw CacheException(400, 'Cache is empty');
      } else {
        return weatherCache.toModel();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setCurrentWeather(
      {required CurrentWeatherModel weatherModel}) async {
    try {
      await _box.put(_key, CurrentWeatherModelLoc.fromModel(weatherModel));
    } catch (error) {
      rethrow;
    }
  }
}
