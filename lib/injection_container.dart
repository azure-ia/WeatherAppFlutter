import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/connection/network_info.dart';

import 'features/current_weather/data/datasources/current_weather_local_data_source.dart';
import 'features/current_weather/data/datasources/current_weather_remote_data_source.dart';
import 'features/current_weather/data/models/current_weather_local_model.dart';
import 'features/current_weather/data/repositories/current_weather_repository_impl.dart';
import 'features/current_weather/domain/repositories/current_weather_repository.dart';
import 'features/current_weather/domain/usecases/current_weather_usecases.dart';
import 'features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'features/forecast_weather/data/datasources/forecast_weather_local_data_source.dart';
import 'features/forecast_weather/data/datasources/forecast_weather_remote_data_source.dart';
import 'features/forecast_weather/data/models/forecast_weather_local_model.dart';
import 'features/forecast_weather/data/repositories/forecast_weather_repository_impl.dart';
import 'features/forecast_weather/domain/repositories/forecast_weather_repository.dart';
import 'features/forecast_weather/domain/usecases/forecast_weather_usecases.dart';
import 'features/forecast_weather/presentation/bloc/forecast_weather_bloc.dart';
import 'features/location/data/datasources/location_local_data_source.dart';
import 'features/location/data/datasources/location_remote_data_source.dart';
import 'features/location/data/models/location_local_model.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/location_usecases.dart';
import 'features/location/presentation/current_location_bloc/current_location_bloc.dart';
import 'features/location/presentation/favorite_locations_bloc/favorite_locations_bloc.dart';
import 'features/location/presentation/locations_bloc/locations_bloc.dart';
import 'features/settings/data/datasources/settings_local_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/setting_usecases.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  await Hive.initFlutter();

  getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());

  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(getIt<DataConnectionChecker>()));

//Current Weather
  Hive.registerAdapter(CurrentWeatherModelLocAdapter());

  var boxCurrentWeatherCache =
      await Hive.openBox<CurrentWeatherModelLoc>('CurrentWeatherCache');

  getIt.registerLazySingleton<CurrentWeatherRemoteDataSource>(
      () => CurrentWeatherRemoteDataSourceImpl());
  getIt.registerLazySingleton<CurrentWeatherLocalDataSource>(
      () => CurrentWeatherLocalDataSourceImpl(boxCurrentWeatherCache));
  getIt.registerLazySingleton<CurrentWeatherRepository>(
      () => CurrentWeatherRepositoryImpl(
            remoteDataSource: getIt<CurrentWeatherRemoteDataSource>(),
            localDataSource: getIt<CurrentWeatherLocalDataSource>(),
            networkInfo: getIt<NetworkInfo>(),
          ));

  getIt.registerLazySingleton<GetCurrentWeather>(
      () => GetCurrentWeather(getIt<CurrentWeatherRepository>()));

  getIt.registerFactory(() => CurrentWeatherBloc(getIt<GetCurrentWeather>()));

  //Weather Forecast
  Hive.registerAdapter(ForecastWeatherModelLocAdapter());

  var boxForecastWeatherCache =
      await Hive.openBox<List<ForecastWeatherModelLoc>>('ForecastWeatherCache');

  getIt.registerLazySingleton<ForecastWeatherRemoteDataSource>(
      () => ForecastWeatherRemoteDataSourceImpl());

  getIt.registerLazySingleton<ForecastWeatherLocalDataSource>(
      () => ForecastWeatherLocalDataSourceImpl(boxForecastWeatherCache));

  getIt.registerLazySingleton<ForecastWeatherRepository>(
      () => ForecastWeatherRepositoryImpl(
            remoteDataSource: getIt<ForecastWeatherRemoteDataSource>(),
            localDataSource: getIt<ForecastWeatherLocalDataSource>(),
            networkInfo: getIt<NetworkInfo>(),
          ));

  getIt.registerLazySingleton<GetForecastWeather>(
      () => GetForecastWeather(getIt<ForecastWeatherRepository>()));

  getIt.registerFactory(() => ForecastWeatherBloc(getIt<GetForecastWeather>()));

//Settings
  getIt.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl());

  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(
        localDataSource: getIt<SettingsLocalDataSource>(),
      ));

  getIt.registerLazySingleton<GetSettings>(
      () => GetSettings(getIt<SettingsRepository>()));
  getIt.registerLazySingleton<SetSettings>(
      () => SetSettings(getIt<SettingsRepository>()));

  getIt.registerFactory(
      () => SettingsBloc(getIt<GetSettings>(), getIt<SetSettings>()));

//Locations
  Hive.registerAdapter(LocationModelLocAdapter());

// Location request
  getIt.registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl());

  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(
        remoteDataSource: getIt<LocationRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ));

  getIt.registerLazySingleton<RequestLocations>(
      () => RequestLocations(getIt<LocationRepository>()));

  getIt.registerFactory(() => LocationsBloc(getIt<RequestLocations>()));

  //Favorite Locations
  var boxFavoriteLocations = await Hive.openBox<List>('FavoriteLocation');

  getIt.registerLazySingleton<FavoriteLocationsLocalDataSource>(
      () => FavoriteLocationsLocalDataSourceImpl(boxFavoriteLocations));

  getIt.registerLazySingleton<FavoriteLocationsRepository>(
      () => FavoriteLocationsRepositoryImpl(
            localDataSource: getIt<FavoriteLocationsLocalDataSource>(),
          ));

  getIt.registerLazySingleton<GetLocations>(
      () => GetLocations(getIt<FavoriteLocationsRepository>()));

  getIt.registerLazySingleton<AddLocation>(
      () => AddLocation(getIt<FavoriteLocationsRepository>()));
  getIt.registerLazySingleton<DeleteLocation>(
      () => DeleteLocation(getIt<FavoriteLocationsRepository>()));

  getIt.registerFactory(() => FavoriteLocationsBloc(
      getIt<GetLocations>(), getIt<AddLocation>(), getIt<DeleteLocation>()));

// Current location
  getIt.registerLazySingleton<CurrentLocationLocalDataSource>(
      () => CurrentLocationLocalDataSourceImpl());

  getIt.registerLazySingleton<CurrentLocationRepository>(
      () => CurrentLocationRepositoryImpl(
            localDataSource: getIt<CurrentLocationLocalDataSource>(),
          ));

  getIt.registerLazySingleton<GetCurrentLocation>(
      () => GetCurrentLocation(getIt<CurrentLocationRepository>()));

  getIt.registerLazySingleton<SetCurrentLocation>(
      () => SetCurrentLocation(getIt<CurrentLocationRepository>()));

  getIt.registerFactory(() => CurrentLocationBloc(
      getIt<GetCurrentLocation>(), getIt<SetCurrentLocation>()));
}
