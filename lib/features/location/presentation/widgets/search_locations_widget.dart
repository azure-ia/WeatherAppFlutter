import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/secrets.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/location_entity.dart';
import '../current_location_bloc/current_location_bloc.dart';
import '../favorite_locations_bloc/favorite_locations_bloc.dart';
import '../locations_bloc/locations_bloc.dart';

class SearchLocationsWidget extends StatefulWidget {
  const SearchLocationsWidget({super.key});

  @override
  State<SearchLocationsWidget> createState() => _SearchLocationsWidgetState();
}

class _SearchLocationsWidgetState extends State<SearchLocationsWidget> {
  final _cityController = TextEditingController();
  var _expanded = false;

  void _submitData() {
    if (_cityController.text.isEmpty) return;

    final city = _cityController.text;
    context.read<LocationsBloc>().add(LoadLocations(
          LocationRequestParams(
            name: city,
            apiKey: openWeatherAPIKey,
          ),
        ));
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(labelText: 'City'),
            controller: _cityController,
            keyboardType: TextInputType.text,
            onSubmitted: (_) => _submitData(),
          ),
        ),
        if (_expanded)
          BlocBuilder<LocationsBloc, LocationsState>(
            builder: (_, state) {
              switch (state) {
                case LocationsInitial() || LocationsLoading():
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(),
                    ),
                  );
                case LocationsError():
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(state.errorMessage),
                    ),
                  );
                case LocationsLoaded():
                  final locations = state.locations;
                  return locations == null
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Cities are not found'),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, index) {
                            return LocationItem(locations[index]);
                          },
                          itemCount: locations.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        );
              }
            },
          )
      ],
    );
  }
}

class LocationItem extends StatelessWidget {
  final LocationEntity location;
  const LocationItem(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CurrentLocationBloc>().add(SaveCurrentLocation(
              location: location,
            ));
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                      '${location.country} ${location.state.isEmpty ? '' : '/${location.state}'}'
                          .trim(),
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<FavoriteLocationsBloc>()
                          .add(AddFavoriteLocation(
                            location: location,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Add',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
