import '../../features/settings/domain/entities/settings_entity.dart';
import '../constants/weather_icons.dart';

class DateConvertor {
  static DateTime unixDateToDateTime(int dateSec, int shiftSec) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      dateSec * 1000,
      isUtc: true,
    );
    return date.add(Duration(seconds: shiftSec));
  }

  static int dateTimeToUnixDate(DateTime date, int shiftSec) {
    final shiftedDate = date.subtract(Duration(seconds: shiftSec));
    return shiftedDate.millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime dateTimeNowTimezone(int shiftSec) {
    return DateTime.now().toUtc().add(Duration(seconds: shiftSec));
  }

  static bool areDatesEqual(DateTime date1, DateTime date2) {
    return (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day);
  }
}

class WeatherHelper {
  static String getWeatherIcon(String weatherId, String iconId) {
    var weatherIconName = '';
    if (iconId.contains('n')) {
      weatherIconName = WEATHER_ICONS['${weatherId}n']?['icon'] ??
          WEATHER_ICONS[weatherId]?['icon'] ??
          'na';
    } else {
      weatherIconName = WEATHER_ICONS['${weatherId}d']?['icon'] ??
          WEATHER_ICONS[weatherId]?['icon'] ??
          'na';
    }
    return 'assets/svg/wi-$weatherIconName.svg';
  }

  static String formatTemperature(double temperature, Units units,
      {bool unitDescr = true}) {
    var unit = '';
    switch (units) {
      case Units.metric:
        {
          unit = '°${unitDescr ? 'C' : ''}';
          break;
        }
      case Units.imperial:
        {
          unit = '°${unitDescr ? 'F' : ''}';
          break;
        }
    }
    return '${temperature.toStringAsFixed(1)}$unit'.trim();
  }

  static String formatPressure(int pressure, Units units) {
    var unit = '';
    switch (units) {
      case Units.metric:
        {
          unit = 'hPa';
          break;
        }
      case Units.imperial:
        {
          unit = 'mbar';
          break;
        }
    }
    return '${pressure.toString()} $unit';
  }

  static String formatWind(double wind, Units units, {bool unitDescr = true}) {
    var unit = '';
    switch (units) {
      case Units.metric:
        {
          unit = unitDescr ? 'm/s' : '';
          break;
        }
      case Units.imperial:
        {
          unit = unitDescr ? 'mi/h' : '';
          break;
        }
    }
    return '${wind.toStringAsFixed(1)} $unit'.trim();
  }

  static String formatHumidity(int humidity, {bool unitDescr = true}) {
    return '${humidity.toString()}${unitDescr ? '%' : ''}'.trim();
  }
}
