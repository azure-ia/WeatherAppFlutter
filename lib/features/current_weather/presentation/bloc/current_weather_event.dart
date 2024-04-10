part of 'current_weather_bloc.dart';

@immutable
sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

final class LoadCurrentWeather extends CurrentWeatherEvent {
  final CurrentWeatherParams params;

  const LoadCurrentWeather({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}
