part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class LoadSettings extends SettingsEvent {
  final SettingsParams params;

  const LoadSettings({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}

final class SaveSettings extends SettingsEvent {
  final SettingsParams params;
  final SettingsEntity settings;

  const SaveSettings({required this.params, required this.settings});

  @override
  List<Object> get props => [params, settings];
}
