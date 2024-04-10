import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exception.dart';
import '../../../../core/params/params.dart';
import '../models/forecast_weather_remote_model.dart';

abstract class ForecastWeatherRemoteDataSource {
  Future<List<ForecastWeatherModel>> getForecastWeather(
      {required ForecastWeatherParams params});
}

class ForecastWeatherRemoteDataSourceImpl
    implements ForecastWeatherRemoteDataSource {
  @override
  Future<List<ForecastWeatherModel>> getForecastWeather(
      {required ForecastWeatherParams params}) async {
    try {
      final uri = Uri.https('api.openweathermap.org', 'data/2.5/forecast', {
        'lat': params.coordLat.toString(),
        'lon': params.coordLon.toString(),
        'appid': params.apiKey,
        'units': params.units.name,
      });

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final city = data['city'] as Map<String, dynamic>;
        final items = data['list'] as List<dynamic>;

        final forecastWeatherList = items.map((item) {
          return ForecastWeatherModel.fromJson(
              listItem: item, cityItem: city, params: params);
        }).toList();
        return forecastWeatherList;
      } else {
        throw APIException(response.statusCode, json.decode(response.body));
      }
    } catch (error) {
      rethrow;
    }
  }
}
