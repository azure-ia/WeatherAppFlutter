import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final double coordLon;
  final double coordLat;
  final String name;
  final String country;
  final String state;

  const LocationEntity(
      {required this.coordLon,
      required this.coordLat,
      required this.name,
      required this.country,
      required this.state});

  @override
  List<Object?> get props => [
        coordLon,
        coordLat,
        name,
        country,
        state,
      ];
}
