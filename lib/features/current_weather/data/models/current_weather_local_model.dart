import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/core/params/params.dart';
import 'package:weather_app/features/settings/domain/entities/settings_entity.dart';

import 'current_weather_remote_model.dart';

part 'current_weather_local_model.g.dart';

@HiveType(typeId: 1)
class CurrentWeatherModelLoc extends Equatable {
  @HiveField(0)
  final double coordLon;

  @HiveField(1)
  final double coordLat;

  @HiveField(2)
  final String weatherId;

  @HiveField(3)
  final String weatherShortDescr;

  @HiveField(4)
  final String weatherLongDescr;

  @HiveField(5)
  final String weatherIcon;

  @HiveField(6)
  final double temp;

  @HiveField(7)
  final double tempFeelsLike;

  @HiveField(8)
  final int pressure;

  @HiveField(9)
  final int humidity;

  @HiveField(10)
  final double windSpeed;

  @HiveField(11)
  final int clouds;

  @HiveField(12)
  final DateTime sunrise;

  @HiveField(13)
  final DateTime sunset;

  @HiveField(14)
  final int timezone;

  @HiveField(15)
  final String units;

  const CurrentWeatherModelLoc(
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

  CurrentWeatherModelLoc.fromModel(CurrentWeatherModel model)
      : this(
            coordLat: model.coordLat,
            coordLon: model.coordLon,
            weatherId: model.weatherId,
            weatherShortDescr: model.weatherShortDescr,
            weatherLongDescr: model.weatherLongDescr,
            weatherIcon: model.weatherIcon,
            temp: model.temp,
            tempFeelsLike: model.tempFeelsLike,
            pressure: model.pressure,
            humidity: model.humidity,
            windSpeed: model.windSpeed,
            clouds: model.clouds,
            sunrise: model.sunrise,
            sunset: model.sunset,
            timezone: model.timezone,
            units: model.units.name);

  CurrentWeatherModel toModel() {
    return CurrentWeatherModel(
      coordLat: coordLat,
      coordLon: coordLon,
      weatherId: weatherId,
      weatherShortDescr: weatherShortDescr,
      weatherLongDescr: weatherLongDescr,
      weatherIcon: weatherIcon,
      temp: temp,
      tempFeelsLike: tempFeelsLike,
      pressure: pressure,
      humidity: humidity,
      windSpeed: windSpeed,
      clouds: clouds,
      sunrise: sunrise,
      sunset: sunset,
      timezone: timezone,
      units: Units.values.firstWhere((value) => value.name == units,
          orElse: () => Units.metric),
    );
  }

  @override
  List<Object?> get props => [
        coordLat,
        coordLon,
        units,
      ];
}
