import 'package:weather_app/features/location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel(
      {required super.coordLon,
      required super.coordLat,
      required super.name,
      required super.country,
      required super.state});

  factory LocationModel.fromJson({required Map<String, dynamic> cityItem}) {
    return LocationModel(
      coordLon: cityItem['lon'],
      coordLat: cityItem['lat'],
      name: cityItem['name'],
      country: cityItem['country'],
      state: cityItem['state'] ?? '',
    );
  }
}
