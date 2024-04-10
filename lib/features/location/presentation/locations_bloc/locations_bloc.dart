import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/location/domain/usecases/location_usecases.dart';

import '../../../../core/params/params.dart';
import '../../domain/entities/location_entity.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final RequestLocations _requestLocations;

  LocationsBloc(this._requestLocations) : super(const LocationsInitial()) {
    on<LoadLocations>(_loadLocations);
  }

  Future<void> _loadLocations(
    LoadLocations event,
    Emitter<LocationsState> emit,
  ) async {
    emit(const LocationsLoading());
    try {
      final locations = await _requestLocations(params: event.params);
      locations.fold(
        (failure) {
          emit(LocationsError(failure.errorMessage));
        },
        (data) {
          emit(LocationsLoaded(data));
        },
      );
    } catch (error) {
      emit(LocationsError(error.toString()));
    }
  }
}
