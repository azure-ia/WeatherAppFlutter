import 'package:equatable/equatable.dart';
import 'package:weather_app/features/settings/domain/entities/settings_entity.dart';

class ForecastWeatherEntity extends Equatable {
  final DateTime dateTime;
  final double coordLon;
  final double coordLat;
  final String weatherId;
  final String weatherShortDescr;
  final String weatherLongDescr;
  final String weatherIcon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double tempFeelsLike;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int clouds;
  final int timezone;
  final Units units;

  const ForecastWeatherEntity(
      {required this.dateTime,
      required this.coordLon,
      required this.coordLat,
      required this.weatherId,
      required this.weatherShortDescr,
      required this.weatherLongDescr,
      required this.weatherIcon,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.tempFeelsLike,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.clouds,
      required this.timezone,
      required this.units});

  @override
  List<Object?> get props => [
        dateTime,
        coordLon,
        coordLat,
        timezone,
        units,
      ];
}
