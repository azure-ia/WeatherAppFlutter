import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/settings_entity.dart';
import '../bloc/settings_bloc.dart';

class SettingsWidget extends StatefulWidget {
  final SettingsEntity settings;
  const SettingsWidget({super.key, required this.settings});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  int _selectedButton = 0;

  @override
  void initState() {
    switch (widget.settings.units) {
      case Units.metric:
        _selectedButton = 0;
      case Units.imperial:
        _selectedButton = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Units:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return _selectedButton == 0
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : Theme.of(context).canvasColor;
                    },
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedButton = 0;
                  });
                  context.read<SettingsBloc>().add(SaveSettings(
                      params: SettingsParams(),
                      settings: const SettingsEntity(units: Units.metric)));
                },
                child: Text(Units.metric.getDescription),
              ),
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return _selectedButton == 1
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : Theme.of(context).canvasColor;
                    },
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedButton = 1;
                  });
                  context.read<SettingsBloc>().add(SaveSettings(
                      params: SettingsParams(),
                      settings: const SettingsEntity(units: Units.imperial)));
                },
                child: Text(Units.imperial.getDescription),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
