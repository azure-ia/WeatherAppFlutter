import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/params/params.dart';
import '../models/location_local_model.dart';

abstract class FavoriteLocationsLocalDataSource {
  Future<List<LocationModelLoc>> getLocations(
      {required FavoriteLocationParams params});
  Future<void> addLocation({required LocationModelLoc location});
  Future<void> deleteLocation({required LocationModelLoc location});
}

abstract class CurrentLocationLocalDataSource {
  Future<LocationModelLoc> getLocation();
  Future<void> setLocation({required LocationModelLoc location});
}

class FavoriteLocationsLocalDataSourceImpl
    implements FavoriteLocationsLocalDataSource {
  final Box<List> _box;
  static const _key = 'locations';

  FavoriteLocationsLocalDataSourceImpl(this._box);

  @override
  Future<List<LocationModelLoc>> getLocations(
      {required FavoriteLocationParams params}) async {
    try {
      final locations = _box.get(_key, defaultValue: <LocationModelLoc>[]);
      return locations!.map((item) => item as LocationModelLoc).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> addLocation({required LocationModelLoc location}) async {
    try {
      var locations = _box.get(_key) ?? <LocationModelLoc>[];
      final locationCheck = locations.contains(location);
      if (!locationCheck) {
        locations.insert(0, location);
        await _box.put(_key, locations);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteLocation({required LocationModelLoc location}) async {
    try {
      var locations = _box.get(_key) ?? <LocationModelLoc>[];
      locations.removeWhere((city) => (city.coordLat == location.coordLat &&
          city.coordLon == location.coordLon));
      await _box.put(_key, locations);
    } catch (error) {
      rethrow;
    }
  }
}

class CurrentLocationLocalDataSourceImpl
    implements CurrentLocationLocalDataSource {
  final String _prefsKey = 'currloc';

  @override
  Future<LocationModelLoc> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey(_prefsKey)) {
        await setLocation(
          location: const LocationModelLoc.defaultValues(),
        );
      }

      return LocationModelLoc.fromJson(
          json.decode(prefs.getString(_prefsKey)!));
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setLocation({
    required LocationModelLoc location,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_prefsKey, json.encode(location.toJson()));
    } catch (error) {
      rethrow;
    }
  }
}
