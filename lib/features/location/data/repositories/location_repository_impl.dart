import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';
import '../datasources/location_remote_data_source.dart';
import '../models/location_local_model.dart';
import '../models/location_remote_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LocationRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  ResultFuture<List<LocationEntity>> requestLocations(
      {required LocationRequestParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<LocationModel> remoteData =
            await remoteDataSource.getLocations(params: params);

        return Right(remoteData.map((item) => item as LocationEntity).toList());
      } on APIException catch (apiError) {
        return Left(
          ServerFailure(
              statusCode: apiError.statusCode,
              message: 'Server exception. ${apiError.message} '),
        );
      } catch (error) {
        return Left(
          ServerFailure(message: 'Server exception. ${error.toString()}'),
        );
      }
    } else {
      return const Left(
        NetworkFailure(message: 'No internet connection.'),
      );
    }
  }
}

class CurrentLocationRepositoryImpl implements CurrentLocationRepository {
  final CurrentLocationLocalDataSource localDataSource;

  CurrentLocationRepositoryImpl({required this.localDataSource});

  @override
  ResultFuture<LocationEntity> getLocation() async {
    try {
      var location = await localDataSource.getLocation();
      return Right(location.toEntity());
    } catch (error) {
      return Left(
        StorageFailure(
            statusCode: 400, message: 'Exception: ${error.toString()}'),
      );
    }
  }

  @override
  ResultFutureVoid setLocation({
    required LocationEntity location,
  }) async {
    try {
      await localDataSource.setLocation(
          location: LocationModelLoc.fromEntity(location));
      return const Right(null);
    } catch (error) {
      return Left(
        StorageFailure(
            statusCode: 400, message: 'Exception: ${error.toString()}'),
      );
    }
  }
}

class FavoriteLocationsRepositoryImpl implements FavoriteLocationsRepository {
  final FavoriteLocationsLocalDataSource localDataSource;

  FavoriteLocationsRepositoryImpl({required this.localDataSource});

  @override
  ResultFuture<List<LocationEntity>> getLocations(
      {required FavoriteLocationParams params}) async {
    try {
      final localData = await localDataSource.getLocations(params: params);
      return Right(localData.map((item) => item.toEntity()).toList());
    } catch (error) {
      return Left(
        StorageFailure(message: 'Storage exception. ${error.toString()}'),
      );
    }
  }

  @override
  ResultFuture<void> addLocation({required LocationEntity location}) async {
    try {
      await localDataSource.addLocation(
          location: LocationModelLoc.fromEntity(location));
      return const Right(null);
    } catch (error) {
      return Left(
        StorageFailure(message: 'Storage exception. ${error.toString()}'),
      );
    }
  }

  @override
  ResultFuture<void> deleteLocation({required LocationEntity location}) async {
    try {
      await localDataSource.deleteLocation(
          location: LocationModelLoc.fromEntity(location));
      return const Right(null);
    } catch (error) {
      return Left(
        StorageFailure(message: 'Storage exception. ${error.toString()}'),
      );
    }
  }
}
