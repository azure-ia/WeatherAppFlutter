part of 'settings_bloc.dart';

@immutable
sealed class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

final class SettingsLoaded extends SettingsState {
  final SettingsEntity settings;

  const SettingsLoaded(this.settings);

  @override
  List<Object> get props => [settings];
}

final class SettingsSaving extends SettingsState {
  const SettingsSaving();
}

final class SettingsSaved extends SettingsState {
  final SettingsEntity settings;

  const SettingsSaved(this.settings);

  @override
  List<Object> get props => [settings];
}

final class SettingsError extends SettingsState {
  final String errorMessage;

  const SettingsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
