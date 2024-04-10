import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/connection/secrets.dart';
import '../core/params/params.dart';
import '../features/current_weather/presentation/bloc/current_weather_bloc.dart';
import '../features/current_weather/presentation/pages/current_weather_page.dart';
import '../features/forecast_weather/presentation/bloc/forecast_weather_bloc.dart';
import '../features/forecast_weather/presentation/pages/forecast_weather_page.dart';
import '../features/location/presentation/current_location_bloc/current_location_bloc.dart';
import '../features/location/presentation/favorite_locations_bloc/favorite_locations_bloc.dart';
import '../features/location/presentation/pages/locations_page.dart';
import '../features/settings/domain/entities/settings_entity.dart';
import '../features/settings/presentation/bloc/settings_bloc.dart';
import 'app_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': const CurrentWeatherPage(), 'title': 'Current Weather'},
      {'page': const ForecastWeatherPage(), 'title': 'Forecast'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _loadData(
      {required double coordLon,
      required double coordLat,
      required Units units}) {
    context.read<CurrentWeatherBloc>().add(
          LoadCurrentWeather(
            params: CurrentWeatherParams(
              coordLon: coordLon,
              coordLat: coordLat,
              apiKey: openWeatherAPIKey,
              units: units,
            ),
          ),
        );
    context.read<ForecastWeatherBloc>().add(
          LoadForecastWeather(
            params: ForecastWeatherParams(
                coordLon: coordLon,
                coordLat: coordLat,
                apiKey: openWeatherAPIKey,
                units: units),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        actions: <Widget>[
          BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
            builder: (_, state) {
              String buttonText;
              if (state is CurrentLocationLoaded) {
                buttonText = state.entity.name;
              } else {
                buttonText = _pages[_selectedPageIndex]['title'] as String;
              }
              return TextButton(
                onPressed: () {
                  context
                      .read<FavoriteLocationsBloc>()
                      .add(LoadFavoriteLocations(FavoriteLocationParams()));
                  Navigator.of(context).pushNamed(LocationsPage.routeName);
                },
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            },
          ),
        ],
      ),
      drawer: const Drawer(
        child: AppDrawer(),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SettingsBloc, SettingsState>(
            listener: (_, state) {
              final locationState = context.read<CurrentLocationBloc>().state;
              if (state is SettingsLoaded &&
                  locationState is CurrentLocationLoaded) {
                _loadData(
                  coordLon: locationState.entity.coordLon,
                  coordLat: locationState.entity.coordLat,
                  units: state.settings.units,
                );
              }
            },
          ),
          BlocListener<CurrentLocationBloc, CurrentLocationState>(
            listener: (_, state) {
              final settingsState = context.read<SettingsBloc>().state;
              if (state is CurrentLocationLoaded &&
                  settingsState is SettingsLoaded) {
                _loadData(
                  coordLon: state.entity.coordLon,
                  coordLat: state.entity.coordLat,
                  units: settingsState.settings.units,
                );
              }
            },
          )
        ],
        child: _pages[_selectedPageIndex]['page'] as Widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedIconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        unselectedIconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Daily',
          ),
        ],
      ),
    );
  }
}
