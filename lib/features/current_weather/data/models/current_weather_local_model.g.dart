// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherModelLocAdapter
    extends TypeAdapter<CurrentWeatherModelLoc> {
  @override
  final int typeId = 1;

  @override
  CurrentWeatherModelLoc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeatherModelLoc(
      coordLon: fields[0] as double,
      coordLat: fields[1] as double,
      weatherId: fields[2] as String,
      weatherShortDescr: fields[3] as String,
      weatherLongDescr: fields[4] as String,
      weatherIcon: fields[5] as String,
      temp: fields[6] as double,
      tempFeelsLike: fields[7] as double,
      pressure: fields[8] as int,
      humidity: fields[9] as int,
      windSpeed: fields[10] as double,
      clouds: fields[11] as int,
      sunrise: fields[12] as DateTime,
      sunset: fields[13] as DateTime,
      timezone: fields[14] as int,
      units: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherModelLoc obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.coordLon)
      ..writeByte(1)
      ..write(obj.coordLat)
      ..writeByte(2)
      ..write(obj.weatherId)
      ..writeByte(3)
      ..write(obj.weatherShortDescr)
      ..writeByte(4)
      ..write(obj.weatherLongDescr)
      ..writeByte(5)
      ..write(obj.weatherIcon)
      ..writeByte(6)
      ..write(obj.temp)
      ..writeByte(7)
      ..write(obj.tempFeelsLike)
      ..writeByte(8)
      ..write(obj.pressure)
      ..writeByte(9)
      ..write(obj.humidity)
      ..writeByte(10)
      ..write(obj.windSpeed)
      ..writeByte(11)
      ..write(obj.clouds)
      ..writeByte(12)
      ..write(obj.sunrise)
      ..writeByte(13)
      ..write(obj.sunset)
      ..writeByte(14)
      ..write(obj.timezone)
      ..writeByte(15)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherModelLocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
