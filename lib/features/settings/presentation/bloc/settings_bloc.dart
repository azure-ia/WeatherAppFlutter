import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/params/params.dart';

import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/setting_usecases.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings _getSettingsUseCase;
  final SetSettings _setSettingsUseCase;

  SettingsBloc(this._getSettingsUseCase, this._setSettingsUseCase)
      : super(const SettingsInitial()) {
    on<LoadSettings>(_getSettings);
    on<SaveSettings>(_setSettings);
  }

  Future<void> _getSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    try {
      final settings = await _getSettingsUseCase(
        params: event.params,
      );
      settings.fold(
        (failure) {
          emit(SettingsError(failure.errorMessage));
        },
        (data) {
          emit(SettingsLoaded(data));
        },
      );
    } catch (error) {
      emit(SettingsError(error.toString()));
    }
  }

  Future<void> _setSettings(
    SaveSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsSaving());
    try {
      await _setSettingsUseCase(
        params: event.params,
        settings: event.settings,
      );
      emit(SettingsSaved(event.settings));
      emit(SettingsLoaded(event.settings));
    } catch (error) {
      emit(SettingsError(error.toString()));
    }
  }
}
