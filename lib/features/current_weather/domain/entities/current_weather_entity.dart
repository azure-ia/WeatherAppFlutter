import 'package:equatable/equatable.dart';
import 'package:weather_app/features/settings/domain/entities/settings_entity.dart';

class CurrentWeatherEntity extends Equatable {
  final double coordLon;
  final double coordLat;
  final String weatherId;
  final String weatherShortDescr;
  final String weatherLongDescr;
  final String weatherIcon;
  final double temp;
  final double tempFeelsLike;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int clouds;
  final DateTime sunrise;
  final DateTime sunset;
  final int timezone;
  final Units units;

  const CurrentWeatherEntity(
      {required this.coordLon,
      required this.coordLat,
      required this.weatherId,
      required this.weatherShortDescr,
      required this.weatherLongDescr,
      required this.weatherIcon,
      required this.temp,
      required this.tempFeelsLike,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.clouds,
      required this.sunrise,
      required this.sunset,
      required this.timezone,
      required this.units});

  @override
  List<Object?> get props => [
        coordLon,
        coordLat,
        weatherId,
        weatherShortDescr,
        weatherLongDescr,
        weatherIcon,
        temp,
        tempFeelsLike,
        pressure,
        humidity,
        windSpeed,
        clouds,
        sunrise,
        sunset,
        timezone,
        units,
      ];
}
