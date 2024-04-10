import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/current_weather/domain/entities/current_weather_entity.dart';

import '../../../../core/utils/utils.dart';

class CurrentWeatherHeader extends StatelessWidget {
  final CurrentWeatherEntity currentWeather;
  const CurrentWeatherHeader({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 280,
                    width: 280,
                    child: SvgPicture.asset(
                      WeatherHelper.getWeatherIcon(
                          currentWeather.weatherId, currentWeather.weatherIcon),
                      fit: BoxFit.fitHeight,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        currentWeather.weatherShortDescr,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat('EEE, dd.MM.yyyy')
                                .format(DateConvertor.dateTimeNowTimezone(
                                    currentWeather.timezone))
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                )),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          WeatherHelper.formatTemperature(
                              currentWeather.temp, currentWeather.units),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Feels like ${WeatherHelper.formatTemperature(
                            currentWeather.tempFeelsLike,
                            currentWeather.units,
                          )}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Divider(
            thickness: 2,
            endIndent: 80,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
