part of 'forecast_weather_bloc.dart';

@immutable
sealed class ForecastWeatherEvent extends Equatable {
  const ForecastWeatherEvent();

  @override
  List<Object> get props => [];
}

final class LoadForecastWeather extends ForecastWeatherEvent {
  final ForecastWeatherParams params;

  const LoadForecastWeather({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}
