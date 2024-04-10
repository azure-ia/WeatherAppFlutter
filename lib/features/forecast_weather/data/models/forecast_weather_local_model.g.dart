// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_weather_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastWeatherModelLocAdapter
    extends TypeAdapter<ForecastWeatherModelLoc> {
  @override
  final int typeId = 2;

  @override
  ForecastWeatherModelLoc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastWeatherModelLoc(
      dateTime: fields[0] as DateTime,
      coordLon: fields[1] as double,
      coordLat: fields[2] as double,
      weatherId: fields[3] as String,
      weatherShortDescr: fields[4] as String,
      weatherLongDescr: fields[5] as String,
      weatherIcon: fields[6] as String,
      temp: fields[7] as double,
      tempMin: fields[8] as double,
      tempMax: fields[9] as double,
      tempFeelsLike: fields[10] as double,
      pressure: fields[11] as int,
      humidity: fields[12] as int,
      windSpeed: fields[13] as double,
      clouds: fields[14] as int,
      timezone: fields[15] as int,
      units: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastWeatherModelLoc obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.coordLon)
      ..writeByte(2)
      ..write(obj.coordLat)
      ..writeByte(3)
      ..write(obj.weatherId)
      ..writeByte(4)
      ..write(obj.weatherShortDescr)
      ..writeByte(5)
      ..write(obj.weatherLongDescr)
      ..writeByte(6)
      ..write(obj.weatherIcon)
      ..writeByte(7)
      ..write(obj.temp)
      ..writeByte(8)
      ..write(obj.tempMin)
      ..writeByte(9)
      ..write(obj.tempMax)
      ..writeByte(10)
      ..write(obj.tempFeelsLike)
      ..writeByte(11)
      ..write(obj.pressure)
      ..writeByte(12)
      ..write(obj.humidity)
      ..writeByte(13)
      ..write(obj.windSpeed)
      ..writeByte(14)
      ..write(obj.clouds)
      ..writeByte(15)
      ..write(obj.timezone)
      ..writeByte(16)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastWeatherModelLocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
