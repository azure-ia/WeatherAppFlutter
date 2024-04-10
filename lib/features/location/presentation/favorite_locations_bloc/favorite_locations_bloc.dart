import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/params/params.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/location_usecases.dart';

part 'favorite_locations_event.dart';
part 'favorite_locations_state.dart';

class FavoriteLocationsBloc
    extends Bloc<FavoriteLocationsEvent, FavoriteLocationsState> {
  final GetLocations _getLocations;
  final AddLocation _addLocation;
  final DeleteLocation _deleteLocation;

  FavoriteLocationsBloc(
      this._getLocations, this._addLocation, this._deleteLocation)
      : super(const FavoriteLocationsInitial()) {
    on<LoadFavoriteLocations>(_loadFavoriteLocations);
    on<AddFavoriteLocation>(_addFavoriteLocation);
    on<DeleteFavoriteLocation>(_deleteFavoriteLocation);
  }

  Future<void> _loadFavoriteLocations(
    LoadFavoriteLocations event,
    Emitter<FavoriteLocationsState> emit,
  ) async {
    emit(const FavoriteLocationsLoading());
    try {
      final locations = await _getLocations(params: event.params);
      locations.fold(
        (failure) {
          emit(FavoriteLocationsError(failure.errorMessage));
        },
        (data) {
          emit(FavoriteLocationsLoaded(data));
        },
      );
    } catch (error) {
      emit(FavoriteLocationsError(error.toString()));
    }
  }

  Future<void> _addFavoriteLocation(
    AddFavoriteLocation event,
    Emitter<FavoriteLocationsState> emit,
  ) async {
    emit(const FavoriteLocationsSaving());
    try {
      final locations = await _addLocation(location: event.location);
      locations.fold(
        (failure) {
          emit(FavoriteLocationsError(failure.errorMessage));
        },
        (data) {
          emit(FavoriteLocationsSaved(event.location));
        },
      );
    } catch (error) {
      emit(FavoriteLocationsError(error.toString()));
    }
  }

  Future<void> _deleteFavoriteLocation(
    DeleteFavoriteLocation event,
    Emitter<FavoriteLocationsState> emit,
  ) async {
    emit(const FavoriteLocationsSaving());
    try {
      final locations = await _deleteLocation(location: event.location);
      locations.fold(
        (failure) {
          emit(FavoriteLocationsError(failure.errorMessage));
        },
        (data) {
          emit(FavoriteLocationsSaved(event.location));
        },
      );
    } catch (error) {
      emit(FavoriteLocationsError(error.toString()));
    }
  }
}
