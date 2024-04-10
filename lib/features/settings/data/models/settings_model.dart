import '../../domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({required super.units});

  SettingsModel.fromEntity(SettingsEntity entity) : this(units: entity.units);

  const SettingsModel.defaultValues() : this(units: Units.metric);

  factory SettingsModel.fromJson({required Map<String, dynamic> json}) {
    return SettingsModel(
      units: Units.values.firstWhere(
        (value) => value.name == (json['units']),
        orElse: () => Units.metric,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'units': units.name};
  }
}
