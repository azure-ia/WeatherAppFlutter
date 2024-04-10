import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/params/params.dart';
import '../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings({
    required SettingsParams params,
  });
  Future<void> setSettings({
    required SettingsParams params,
    required SettingsModel settings,
  });
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final String _prefsKey = 'settings';

  @override
  Future<SettingsModel> getSettings({required SettingsParams params}) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey(_prefsKey)) {
        await setSettings(
          params: params,
          settings: const SettingsModel.defaultValues(),
        );
      }

      return SettingsModel.fromJson(
          json: json.decode(prefs.getString(_prefsKey)!));
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setSettings({
    required SettingsParams params,
    required SettingsModel settings,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_prefsKey, json.encode(settings.toJson()));
    } catch (error) {
      rethrow;
    }
  }
}
