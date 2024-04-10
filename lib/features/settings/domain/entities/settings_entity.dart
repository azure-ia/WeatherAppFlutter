import 'package:equatable/equatable.dart';

enum Units {
  metric,
  imperial;

  String get getTitle {
    switch (this) {
      case metric:
        return 'Metric';
      case imperial:
        return 'Imperial';
      default:
        return 'Unknown';
    }
  }

  String get getDescription {
    switch (this) {
      case metric:
        return 'C,m/s,mm';
      case imperial:
        return 'F,mph,in';
      default:
        return 'Unknown';
    }
  }
}

class SettingsEntity extends Equatable {
  final Units units;

  const SettingsEntity({required this.units});

  @override
  List<Object?> get props => [units];
}
