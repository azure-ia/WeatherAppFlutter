import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exception.dart';
import '../../../../core/params/params.dart';
import '../models/location_remote_model.dart';

abstract class LocationRemoteDataSource {
  Future<List<LocationModel>> getLocations(
      {required LocationRequestParams params});
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<List<LocationModel>> getLocations(
      {required LocationRequestParams params}) async {
    try {
      final uri = Uri.https('api.openweathermap.org', 'geo/1.0/direct', {
        'q': params.name,
        'appid': params.apiKey,
        'limit': '5',
      });

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final items = json.decode(response.body) as List<dynamic>;
        final locationsList = items.map((item) {
          return LocationModel.fromJson(cityItem: item);
        }).toList();
        return locationsList;
      } else {
        throw APIException(response.statusCode, json.decode(response.body));
      }
    } catch (error) {
      rethrow;
    }
  }
}
