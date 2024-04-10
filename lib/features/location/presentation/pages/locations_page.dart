import 'package:flutter/material.dart';

import '../widgets/favorite_locations_widget.dart';
import '../widgets/search_locations_widget.dart';

class LocationsPage extends StatelessWidget {
  static const String routeName = 'locations';
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchLocationsWidget(),
            FavoriteLocationsWidget(),
          ],
        ),
      ),
    );
  }
}
