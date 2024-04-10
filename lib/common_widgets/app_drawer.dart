import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/params/params.dart';
import '../features/settings/presentation/bloc/settings_bloc.dart';
import '../features/settings/presentation/pages/settings_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Weather'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context
                  .read<SettingsBloc>()
                  .add(LoadSettings(params: SettingsParams()));
              Navigator.of(context).pushNamed(SettingsPage.routeName);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
