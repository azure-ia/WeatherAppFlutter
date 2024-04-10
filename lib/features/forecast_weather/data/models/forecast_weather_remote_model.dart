import 'package:weather_app/core/params/params.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/forecast_weather_entity.dart';

class ForecastWeatherModel extends ForecastWeatherEntity {
  const ForecastWeatherModel(
      {required super.dateTime,
      required super.coordLon,
      required super.coordLat,
      required super.weatherId,
      required super.weatherShortDescr,
      required super.weatherLongDescr,
      required super.weatherIcon,
      required super.temp,
      required super.tempMin,
      required super.tempMax,
      required super.tempFeelsLike,
      required super.pressure,
      required super.humidity,
      required super.windSpeed,
      required super.clouds,
      required super.timezone,
      required super.units});

  factory ForecastWeatherModel.fromJson(
      {required Map<String, dynamic> listItem,
      required Map<String, dynamic> cityItem,
      required ForecastWeatherParams params}) {
    return ForecastWeatherModel(
      dateTime: DateConvertor.unixDateToDateTime(
          listItem['dt'], cityItem['timezone']),
      coordLon: params.coordLon,
      coordLat: params.coordLat,
      weatherId: listItem['weather'][0]['id'].toString(),
      weatherShortDescr: listItem['weather'][0]['main'],
      weatherLongDescr: listItem['weather'][0]['description'],
      weatherIcon: listItem['weather'][0]['icon'],
      temp: (listItem['main']['temp'] as num).toDouble(),
      tempMin: (listItem['main']['temp_min'] as num).toDouble(),
      tempMax: (listItem['main']['temp_max'] as num).toDouble(),
      tempFeelsLike: (listItem['main']['feels_like'] as num).toDouble(),
      pressure: listItem['main']['pressure'],
      humidity: listItem['main']['humidity'],
      windSpeed: (listItem['wind']['speed'] as num).toDouble(),
      clouds: listItem['clouds']['all'],
      timezone: cityItem['timezone'],
      units: params.units,
    );
  }
}
