part of 'forecast_weather_bloc.dart';

@immutable
sealed class ForecastWeatherState extends Equatable {
  const ForecastWeatherState();
  @override
  List<Object> get props => [];
}

final class ForecastWeatherInitial extends ForecastWeatherState {
  const ForecastWeatherInitial();
}

final class ForecastWeatherLoading extends ForecastWeatherState {
  const ForecastWeatherLoading();
}

final class ForecastWeatherLoaded extends ForecastWeatherState {
  final List<ForecastWeatherEntity> weatherForecast;

  const ForecastWeatherLoaded(this.weatherForecast);

  @override
  List<Object> get props => [weatherForecast];
}

final class ForecastWeatherError extends ForecastWeatherState {
  final String errorMessage;

  const ForecastWeatherError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
