part of 'favorite_locations_bloc.dart';

@immutable
sealed class FavoriteLocationsEvent extends Equatable {
  const FavoriteLocationsEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteLocations extends FavoriteLocationsEvent {
  final FavoriteLocationParams params;

  const LoadFavoriteLocations(this.params);

  @override
  List<Object> get props => [params];
}

final class AddFavoriteLocation extends FavoriteLocationsEvent {
  final LocationEntity location;

  const AddFavoriteLocation({required this.location});

  @override
  List<Object> get props => [location];
}

final class DeleteFavoriteLocation extends FavoriteLocationsEvent {
  final LocationEntity location;

  const DeleteFavoriteLocation({required this.location});

  @override
  List<Object> get props => [location];
}
