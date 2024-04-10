// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelLocAdapter extends TypeAdapter<LocationModelLoc> {
  @override
  final int typeId = 3;

  @override
  LocationModelLoc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModelLoc(
      coordLon: fields[0] as double,
      coordLat: fields[1] as double,
      name: fields[2] as String,
      country: fields[3] as String,
      state: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocationModelLoc obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.coordLon)
      ..writeByte(1)
      ..write(obj.coordLat)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelLocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModelLoc _$LocationModelLocFromJson(Map<String, dynamic> json) =>
    LocationModelLoc(
      coordLon: (json['coordLon'] as num).toDouble(),
      coordLat: (json['coordLat'] as num).toDouble(),
      name: json['name'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$LocationModelLocToJson(LocationModelLoc instance) =>
    <String, dynamic>{
      'coordLon': instance.coordLon,
      'coordLat': instance.coordLat,
      'name': instance.name,
      'country': instance.country,
      'state': instance.state,
    };
