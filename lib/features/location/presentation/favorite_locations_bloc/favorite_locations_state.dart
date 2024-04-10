part of 'favorite_locations_bloc.dart';

@immutable
sealed class FavoriteLocationsState extends Equatable {
  const FavoriteLocationsState();
  @override
  List<Object> get props => [];
}

final class FavoriteLocationsInitial extends FavoriteLocationsState {
  const FavoriteLocationsInitial();
}

final class FavoriteLocationsLoading extends FavoriteLocationsState {
  const FavoriteLocationsLoading();
}

final class FavoriteLocationsLoaded extends FavoriteLocationsState {
  final List<LocationEntity> locations;

  const FavoriteLocationsLoaded(this.locations);

  @override
  List<Object> get props => [locations];
}

final class FavoriteLocationsSaving extends FavoriteLocationsState {
  const FavoriteLocationsSaving();
}

final class FavoriteLocationsSaved extends FavoriteLocationsState {
  final LocationEntity location;

  const FavoriteLocationsSaved(this.location);

  @override
  List<Object> get props => [location];
}

final class FavoriteLocationsError extends FavoriteLocationsState {
  final String errorMessage;

  const FavoriteLocationsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
