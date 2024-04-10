import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/location/presentation/current_location_bloc/current_location_bloc.dart';

import '../../../../core/params/params.dart';
import '../favorite_locations_bloc/favorite_locations_bloc.dart';

class FavoriteLocationsWidget extends StatelessWidget {
  const FavoriteLocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteLocationsBloc, FavoriteLocationsState>(
      builder: (_, state) {
        switch (state) {
          case FavoriteLocationsInitial() ||
                FavoriteLocationsLoading() ||
                FavoriteLocationsSaving():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case FavoriteLocationsSaved():
            context
                .read<FavoriteLocationsBloc>()
                .add(LoadFavoriteLocations(FavoriteLocationParams()));
            return const Center(
              child: CircularProgressIndicator(),
            );
          case FavoriteLocationsError():
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(state.errorMessage),
              ),
            );
          case FavoriteLocationsLoaded():
            final locations = state.locations;
            return (locations == null || locations.isEmpty)
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Cities are not found'),
                    ),
                  )
                : Column(
                    children: [
                      const Divider(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Favorite cities',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      ListView.builder(
                        itemBuilder: ((ctx, index) {
                          return LocationItem(locations[index]);
                        }),
                        itemCount: locations.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  );
        }
      },
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
      child: Dismissible(
        key: ValueKey('${location.coordLat}_${location.coordLon}'),
        background: Container(
          color: Theme.of(context).colorScheme.secondary,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<FavoriteLocationsBloc>().add(
                DeleteFavoriteLocation(
                  location: location,
                ),
              );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            ],
          ),
        ),
      ),
    );
  }
}
