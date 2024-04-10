part of 'current_location_bloc.dart';

@immutable
sealed class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();

  @override
  List<Object> get props => [];
}

final class LoadCurrentLocation extends CurrentLocationEvent {
  const LoadCurrentLocation();
}

final class SaveCurrentLocation extends CurrentLocationEvent {
  final LocationEntity location;

  const SaveCurrentLocation({required this.location});

  @override
  List<Object> get props => [location];
}
