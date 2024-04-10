import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/current_weather_bloc.dart';
import '../widgets/current_weather_details.dart';
import '../widgets/current_weather_header.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (_, state) {
        switch (state) {
          case CurrentWeatherInitial() || CurrentWeatherLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case CurrentWeatherError():
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(state.errorMessage),
              ),
            );
          case CurrentWeatherLoaded():
            final currentWeather = state.currentWeather;
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CurrentWeatherHeader(
                      currentWeather: currentWeather,
                    ),
                    CurrentWeatherDetails(
                      currentWeather: currentWeather,
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
