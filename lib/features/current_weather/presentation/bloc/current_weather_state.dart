part of 'current_weather_bloc.dart';

@immutable
sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
  @override
  List<Object> get props => [];
}

final class CurrentWeatherInitial extends CurrentWeatherState {
  const CurrentWeatherInitial();
}

final class CurrentWeatherLoading extends CurrentWeatherState {
  const CurrentWeatherLoading();
}

final class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeatherEntity currentWeather;

  const CurrentWeatherLoaded(this.currentWeather);

  @override
  List<Object> get props => [currentWeather];
}

final class CurrentWeatherError extends CurrentWeatherState {
  final String errorMessage;

  const CurrentWeatherError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
