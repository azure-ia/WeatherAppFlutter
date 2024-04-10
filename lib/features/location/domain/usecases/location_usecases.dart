import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class RequestLocations {
  final LocationRepository repository;

  const RequestLocations(this.repository);

  ResultFuture<List<LocationEntity>> call({
    required LocationRequestParams params,
  }) async {
    return await repository.requestLocations(params: params);
  }
}

class GetLocations {
  final FavoriteLocationsRepository repository;

  const GetLocations(this.repository);

  ResultFuture<List<LocationEntity>> call({
    required FavoriteLocationParams params,
  }) async {
    return await repository.getLocations(params: params);
  }
}

class AddLocation {
  final FavoriteLocationsRepository repository;

  const AddLocation(this.repository);

  ResultFuture<void> call({
    required LocationEntity location,
  }) async {
    return await repository.addLocation(location: location);
  }
}

class DeleteLocation {
  final FavoriteLocationsRepository repository;

  const DeleteLocation(this.repository);

  ResultFuture<void> call({
    required LocationEntity location,
  }) async {
    return await repository.deleteLocation(location: location);
  }
}

class GetCurrentLocation {
  final CurrentLocationRepository repository;

  const GetCurrentLocation(this.repository);

  ResultFuture<LocationEntity> call() async {
    return await repository.getLocation();
  }
}

class SetCurrentLocation {
  final CurrentLocationRepository repository;

  const SetCurrentLocation(this.repository);

  ResultFutureVoid call({
    required LocationEntity location,
  }) async {
    return await repository.setLocation(
      location: location,
    );
  }
}
