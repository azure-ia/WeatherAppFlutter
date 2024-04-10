import 'package:weather_app/core/params/params.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/current_weather_entity.dart';

class CurrentWeatherModel extends CurrentWeatherEntity {
  const CurrentWeatherModel(
      {required super.coordLon,
      required super.coordLat,
      required super.weatherId,
      required super.weatherShortDescr,
      required super.weatherLongDescr,
      required super.weatherIcon,
      required super.temp,
      required super.tempFeelsLike,
      required super.pressure,
      required super.humidity,
      required super.windSpeed,
      required super.clouds,
      required super.sunrise,
      required super.sunset,
      required super.timezone,
      required super.units});

  factory CurrentWeatherModel.fromJson(
      {required Map<String, dynamic> json,
      required CurrentWeatherParams params}) {
    return CurrentWeatherModel(
      coordLon: params.coordLon,
      coordLat: params.coordLat,
      weatherId: json['weather'][0]['id'].toString(),
      weatherShortDescr: json['weather'][0]['main'],
      weatherLongDescr: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      temp: (json['main']['temp'] as num).toDouble(),
      tempFeelsLike: (json['main']['feels_like'] as num).toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      clouds: json['clouds']['all'],
      sunrise: DateConvertor.unixDateToDateTime(
          json['sys']['sunrise'], json['timezone']),
      sunset: DateConvertor.unixDateToDateTime(
          json['sys']['sunset'], json['timezone']),
      timezone: json['timezone'],
      units: params.units,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': {'lon': coordLon, 'lat': coordLat},
      'weather': [
        {
          'id': weatherId,
          'main': weatherShortDescr,
          'description': weatherShortDescr,
          'icon': weatherIcon
        }
      ],
      'main': {
        'temp': temp,
        'feels_like': tempFeelsLike,
        'pressure': pressure,
        'humidity': humidity
      },
      'wind': {'speed': windSpeed},
      'sys': {
        'sunrise': DateConvertor.dateTimeToUnixDate(sunrise, timezone ?? 0),
        'sunset': DateConvertor.dateTimeToUnixDate(sunset, timezone ?? 0),
      },
      'timezone': timezone,
      'units': units.name
    };
  }
}
