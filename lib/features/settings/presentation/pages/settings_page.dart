import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';
import '../widgets/settings_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = 'settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (_, state) {
          switch (state) {
            case SettingsInitial() ||
                  SettingsLoading() ||
                  SettingsSaving() ||
                  SettingsSaved():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SettingsError():
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(state.errorMessage),
                ),
              );
            case SettingsLoaded():
              final settings = state.settings;
              return SettingsWidget(
                settings: settings,
              );
          }
        },
      ),
    );
  }
}
