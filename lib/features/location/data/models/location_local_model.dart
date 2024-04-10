import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/location_entity.dart';

part 'location_local_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class LocationModelLoc extends Equatable {
  @HiveField(0)
  final double coordLon;
  @HiveField(1)
  final double coordLat;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String state;

  const LocationModelLoc(
      {required this.coordLon,
      required this.coordLat,
      required this.name,
      required this.country,
      required this.state});

  const LocationModelLoc.defaultValues()
      : this(
            coordLat: 0.0,
            coordLon: 0.0,
            country: '',
            name: 'Null Island',
            state: '');

  factory LocationModelLoc.fromJson(Map<String, dynamic> json) =>
      _$LocationModelLocFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelLocToJson(this);

  LocationModelLoc.fromEntity(LocationEntity entity)
      : this(
            coordLat: entity.coordLat,
            coordLon: entity.coordLon,
            name: entity.name,
            country: entity.country,
            state: entity.state);

  LocationEntity toEntity() {
    return LocationEntity(
      coordLat: coordLat,
      coordLon: coordLon,
      name: name,
      country: country,
      state: state,
    );
  }

  @override
  List<Object?> get props => [
        coordLon,
        coordLat,
      ];
}
