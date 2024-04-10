import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/params/params.dart';
import '../../domain/entities/forecast_weather_entity.dart';
import '../../domain/usecases/forecast_weather_usecases.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc
    extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {
  final GetForecastWeather _getForecastWeatherUseCase;

  ForecastWeatherBloc(this._getForecastWeatherUseCase)
      : super(const ForecastWeatherInitial()) {
    on<LoadForecastWeather>(_getForecastWeather);
  }

  Future<void> _getForecastWeather(
    LoadForecastWeather event,
    Emitter<ForecastWeatherState> emit,
  ) async {
    emit(const ForecastWeatherLoading());
    try {
      final weather = await _getForecastWeatherUseCase(
        params: event.params,
      );
      weather.fold(
        (failure) {
          emit(ForecastWeatherError(failure.errorMessage));
        },
        (data) {
          emit(ForecastWeatherLoaded(data));
        },
      );
    } catch (error) {
      emit(ForecastWeatherError(error.toString()));
    }
  }
}
