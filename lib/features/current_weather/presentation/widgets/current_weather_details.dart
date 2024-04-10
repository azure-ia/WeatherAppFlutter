import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/current_weather_entity.dart';

class CurrentWeatherDetails extends StatelessWidget {
  final CurrentWeatherEntity currentWeather;
  const CurrentWeatherDetails({super.key, required this.currentWeather});

  Widget detailListTile(
      BuildContext context, String assetPath, String title, String value) {
    return ListTile(
      dense: true,
      leading: SvgPicture.asset(
        assetPath,
        height: 40,
        width: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold)),
      trailing: Text(
        value,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailListTile(context, 'assets/svg/wi-cloud.svg', 'Clouds',
              '${currentWeather.clouds.toString()}%'),
          detailListTile(context, 'assets/svg/wi-humidity.svg', 'Humidity',
              WeatherHelper.formatHumidity(currentWeather.humidity)),
          detailListTile(
            context,
            'assets/svg/wi-strong-wind.svg',
            'Wind speed',
            WeatherHelper.formatWind(
                currentWeather.windSpeed, currentWeather.units),
          ),
          detailListTile(
            context,
            'assets/svg/wi-barometer.svg',
            'Pressure',
            WeatherHelper.formatPressure(
                currentWeather.pressure, currentWeather.units),
          ),
          detailListTile(context, 'assets/svg/wi-sunrise.svg', 'Sunrise',
              DateFormat('HH:mm').format(currentWeather.sunrise)),
          detailListTile(context, 'assets/svg/wi-sunset.svg', 'Sunset',
              DateFormat('HH:mm').format(currentWeather.sunset)),
        ],
      ),
    );
  }
}
