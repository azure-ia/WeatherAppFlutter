part of 'current_location_bloc.dart';

@immutable
sealed class CurrentLocationState extends Equatable {
  const CurrentLocationState();
  @override
  List<Object> get props => [];
}

final class CurrentLocationInitial extends CurrentLocationState {
  const CurrentLocationInitial();
}

final class CurrentLocationLoading extends CurrentLocationState {
  const CurrentLocationLoading();
}

final class CurrentLocationLoaded extends CurrentLocationState {
  final LocationEntity entity;

  const CurrentLocationLoaded(this.entity);

  @override
  List<Object> get props => [entity];
}

final class CurrentLocationSaving extends CurrentLocationState {
  const CurrentLocationSaving();
}

final class CurrentLocationSaved extends CurrentLocationState {
  final LocationEntity entity;

  const CurrentLocationSaved(this.entity);

  @override
  List<Object> get props => [entity];
}

final class CurrentLocationError extends CurrentLocationState {
  final String errorMessage;

  const CurrentLocationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
