part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

final class LoadLocations extends LocationsEvent {
  final LocationRequestParams params;
  const LoadLocations(this.params);
  @override
  List<Object> get props => [params];
}
