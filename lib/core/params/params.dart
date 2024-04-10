import '../../features/settings/domain/entities/settings_entity.dart';

class CurrentWeatherParams {
  final double coordLon;
  final double coordLat;
  final String apiKey;
  final Units units;

  CurrentWeatherParams(
      {required this.coordLon,
      required this.coordLat,
      required this.apiKey,
      required this.units});
}

class ForecastWeatherParams {
  final double coordLon;
  final double coordLat;
  final String apiKey;
  final Units units;

  ForecastWeatherParams(
      {required this.coordLon,
      required this.coordLat,
      required this.apiKey,
      required this.units});
}

class SettingsParams {}

class LocationRequestParams {
  final String name;
  final String apiKey;

  LocationRequestParams({
    required this.name,
    required this.apiKey,
  });
}

class FavoriteLocationParams {
  FavoriteLocationParams();
}
