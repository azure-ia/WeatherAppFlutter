import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/params/params.dart';
import 'package:weather_app/features/current_weather/domain/entities/current_weather_entity.dart';
import '../../domain/usecases/current_weather_usecases.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeather _getCurrentWeatherUseCase;

  CurrentWeatherBloc(this._getCurrentWeatherUseCase)
      : super(const CurrentWeatherInitial()) {
    on<LoadCurrentWeather>(_getCurrentWeather);
  }

  Future<void> _getCurrentWeather(
    LoadCurrentWeather event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    emit(const CurrentWeatherLoading());
    try {
      final weather = await _getCurrentWeatherUseCase(
        params: event.params,
      );
      weather.fold(
        (failure) {
          emit(CurrentWeatherError(failure.errorMessage));
        },
        (data) {
          emit(CurrentWeatherLoaded(data));
        },
      );
    } catch (error) {
      emit(CurrentWeatherError(error.toString()));
    }
  }
}
