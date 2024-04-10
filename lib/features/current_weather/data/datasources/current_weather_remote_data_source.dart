import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exception.dart';
import '../../../../core/params/params.dart';
import '../models/current_weather_remote_model.dart';

abstract class CurrentWeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather(
      {required CurrentWeatherParams params});
}

class CurrentWeatherRemoteDataSourceImpl
    implements CurrentWeatherRemoteDataSource {
  @override
  Future<CurrentWeatherModel> getCurrentWeather(
      {required CurrentWeatherParams params}) async {
    try {
      final uri = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
        'lat': params.coordLat.toString(),
        'lon': params.coordLon.toString(),
        'appid': params.apiKey,
        'units': params.units.name,
      });

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return CurrentWeatherModel.fromJson(
            json: json.decode(response.body), params: params);
      } else {
        throw APIException(response.statusCode, json.decode(response.body));
      }
    } catch (error) {
      rethrow;
    }
  }
}
