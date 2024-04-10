import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/forecast_weather_entity.dart';

class ForecastWeatherList extends StatelessWidget {
  final List<ForecastWeatherEntity> weatherForecast;
  const ForecastWeatherList({super.key, required this.weatherForecast});

  @override
  Widget build(BuildContext context) {
    final datesSet = weatherForecast
        .map((item) => DateTime(
            item.dateTime.year, item.dateTime.month, item.dateTime.day))
        .toSet()
        .toList();

    return ListView.builder(
      itemBuilder: ((ctx, index) {
        final dayList = weatherForecast.where(
          (item) {
            return DateConvertor.areDatesEqual(item.dateTime, datesSet[index]);
          },
        ).toList();
        return DayForecastItem(dayList);
      }),
      itemCount: datesSet.length,
    );
  }
}

class DayForecastItem extends StatefulWidget {
  final List<ForecastWeatherEntity> dayForecast;

  const DayForecastItem(this.dayForecast, {super.key});

  @override
  State<DayForecastItem> createState() => _DayForecastItemState();
}

class _DayForecastItemState extends State<DayForecastItem> {
  var _expanded = false;

  Widget dayForecastOverview() {
    final items = widget.dayForecast;
    final itemFirst = items.first;
    // final itemTempMin =
    //     items.reduce((curr, next) => curr.tempMin < next.tempMin ? curr : next);
    final itemTempMax =
        items.reduce((curr, next) => curr.tempMax > next.tempMax ? curr : next);
    final itemDay = items.firstWhere(
        (item) => (item.dateTime.hour >= 12 && item.dateTime.hour <= 15),
        orElse: () => itemFirst);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 70,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  DateConvertor.areDatesEqual(
                          DateConvertor.dateTimeNowTimezone(itemFirst.timezone),
                          itemFirst.dateTime)
                      ? 'TODAY'
                      : DateFormat('EEE')
                          .format(itemFirst.dateTime)
                          .toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              Text(DateFormat('dd.MM').format(itemFirst.dateTime),
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: SvgPicture.asset(
                WeatherHelper.getWeatherIcon(
                    itemDay.weatherId, itemDay.weatherIcon),
                fit: BoxFit.fitHeight,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  WeatherHelper.formatTemperature(
                      itemTempMax.temp, itemTempMax.units),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
              Text(
                  'Feels like ${WeatherHelper.formatTemperature(
                    itemTempMax.tempFeelsLike,
                    itemTempMax.units,
                  )}',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/wi-humidity.svg',
                    height: 20,
                    width: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(WeatherHelper.formatHumidity(itemDay.humidity),
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/wi-strong-wind.svg',
                    height: 20,
                    width: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                      WeatherHelper.formatWind(
                          itemDay.windSpeed, itemDay.units),
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget hoursForecast() {
    final items = widget.dayForecast;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: Theme.of(context).splashColor,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: ((ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat('HH:mm').format(items[index].dateTime),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: SvgPicture.asset(
                    WeatherHelper.getWeatherIcon(
                        items[index].weatherId, items[index].weatherIcon),
                    fit: BoxFit.fitHeight,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                    WeatherHelper.formatTemperature(
                        items[index].tempMax, items[index].units,
                        unitDescr: false),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const Divider(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/wi-humidity.svg',
                      height: 20,
                      width: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                        WeatherHelper.formatHumidity(items[index].humidity,
                            unitDescr: false),
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/wi-strong-wind.svg',
                      height: 20,
                      width: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                        WeatherHelper.formatWind(
                            items[index].windSpeed, items[index].units,
                            unitDescr: false),
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          );
        }),
        itemCount: items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            dayForecastOverview(),
            if (_expanded) hoursForecast(),
          ],
        ),
      ),
    );
  }
}
