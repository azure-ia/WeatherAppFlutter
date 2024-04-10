part of 'locations_bloc.dart';

@immutable
sealed class LocationsState extends Equatable {
  const LocationsState();
  @override
  List<Object?> get props => [];
}

final class LocationsInitial extends LocationsState {
  const LocationsInitial();
}

final class LocationsLoading extends LocationsState {
  const LocationsLoading();
}

final class LocationsLoaded extends LocationsState {
  final List<LocationEntity> locations;

  const LocationsLoaded(this.locations);

  @override
  List<Object> get props => [locations];
}

final class LocationsError extends LocationsState {
  final String errorMessage;

  const LocationsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
