import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/location_entity.dart';

abstract class LocationRepository {
  ResultFuture<List<LocationEntity>> requestLocations({
    required LocationRequestParams params,
  });
}

abstract class FavoriteLocationsRepository {
  ResultFuture<List<LocationEntity>> getLocations({
    required FavoriteLocationParams params,
  });

  ResultFuture<void> addLocation({
    required LocationEntity location,
  });

  ResultFuture<void> deleteLocation({
    required LocationEntity location,
  });
}

abstract class CurrentLocationRepository {
  ResultFuture<LocationEntity> getLocation();

  ResultFutureVoid setLocation({
    required LocationEntity location,
  });
}
