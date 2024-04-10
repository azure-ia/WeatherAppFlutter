import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../../settings/domain/entities/settings_entity.dart';
import 'forecast_weather_remote_model.dart';

part 'forecast_weather_local_model.g.dart';

@HiveType(typeId: 2)
class ForecastWeatherModelLoc extends Equatable {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final double coordLon;

  @HiveField(2)
  final double coordLat;

  @HiveField(3)
  final String weatherId;

  @HiveField(4)
  final String weatherShortDescr;

  @HiveField(5)
  final String weatherLongDescr;

  @HiveField(6)
  final String weatherIcon;

  @HiveField(7)
  final double temp;

  @HiveField(8)
  final double tempMin;

  @HiveField(9)
  final double tempMax;

  @HiveField(10)
  final double tempFeelsLike;

  @HiveField(11)
  final int pressure;

  @HiveField(12)
  final int humidity;

  @HiveField(13)
  final double windSpeed;

  @HiveField(14)
  final int clouds;

  @HiveField(15)
  final int timezone;

  @HiveField(16)
  final String units;

  const ForecastWeatherModelLoc(
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

  ForecastWeatherModelLoc.fromModel(ForecastWeatherModel model)
      : this(
            dateTime: model.dateTime,
            coordLat: model.coordLat,
            coordLon: model.coordLon,
            weatherId: model.weatherId,
            weatherShortDescr: model.weatherShortDescr,
            weatherLongDescr: model.weatherLongDescr,
            weatherIcon: model.weatherIcon,
            temp: model.temp,
            tempMin: model.tempMin,
            tempMax: model.tempMax,
            tempFeelsLike: model.tempFeelsLike,
            pressure: model.pressure,
            humidity: model.humidity,
            windSpeed: model.windSpeed,
            clouds: model.clouds,
            timezone: model.timezone,
            units: model.units.name);

  ForecastWeatherModel toModel() {
    return ForecastWeatherModel(
      dateTime: dateTime,
      coordLat: coordLat,
      coordLon: coordLon,
      weatherId: weatherId,
      weatherShortDescr: weatherShortDescr,
      weatherLongDescr: weatherLongDescr,
      weatherIcon: weatherIcon,
      temp: temp,
      tempMin: tempMin,
      tempMax: tempMax,
      tempFeelsLike: tempFeelsLike,
      pressure: pressure,
      humidity: humidity,
      windSpeed: windSpeed,
      clouds: clouds,
      timezone: timezone,
      units: Units.values.firstWhere((value) => value.name == units,
          orElse: () => Units.metric),
    );
  }

  @override
  List<Object?> get props => [
        dateTime,
        coordLat,
        coordLon,
        units,
      ];
}
