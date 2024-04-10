import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/forecast_weather_bloc.dart';
import '../widgets/forecast_weather_list.dart';

class ForecastWeatherPage extends StatelessWidget {
  const ForecastWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
      builder: (_, state) {
        switch (state) {
          case ForecastWeatherInitial() || ForecastWeatherLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ForecastWeatherError():
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(state.errorMessage),
              ),
            );
          case ForecastWeatherLoaded():
            final weatherForecastList = state.weatherForecast;
            return ForecastWeatherList(
              weatherForecast: weatherForecastList,
            );
        }
      },
    );
  }
}
