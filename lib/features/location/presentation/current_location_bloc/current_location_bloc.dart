import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/location_usecases.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  final GetCurrentLocation _getCurrentLocation;
  final SetCurrentLocation _setCurrentLocation;

  CurrentLocationBloc(this._getCurrentLocation, this._setCurrentLocation)
      : super(const CurrentLocationInitial()) {
    on<LoadCurrentLocation>(_getLocation);
    on<SaveCurrentLocation>(_setLocation);
  }

  Future<void> _getLocation(
    LoadCurrentLocation event,
    Emitter<CurrentLocationState> emit,
  ) async {
    emit(const CurrentLocationLoading());
    try {
      final location = await _getCurrentLocation();
      location.fold(
        (failure) {
          emit(CurrentLocationError(failure.errorMessage));
        },
        (data) {
          emit(CurrentLocationLoaded(data));
        },
      );
    } catch (error) {
      emit(CurrentLocationError(error.toString()));
    }
  }

  Future<void> _setLocation(
    SaveCurrentLocation event,
    Emitter<CurrentLocationState> emit,
  ) async {
    emit(const CurrentLocationSaving());
    try {
      await _setCurrentLocation(
        location: event.location,
      );
      emit(CurrentLocationSaved(event.location));
      emit(CurrentLocationLoaded(event.location));
    } catch (error) {
      emit(CurrentLocationError(error.toString()));
    }
  }
}
