import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/presentation/pages/locations_page.dart';

import 'package:weather_app/features/settings/presentation/pages/settings_page.dart';
import 'package:weather_app/theme.dart';
import 'package:weather_app/injection_container.dart';
import 'core/params/params.dart';
import 'features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'features/forecast_weather/presentation/bloc/forecast_weather_bloc.dart';
import 'features/location/presentation/current_location_bloc/current_location_bloc.dart';
import 'features/location/presentation/favorite_locations_bloc/favorite_locations_bloc.dart';
import 'features/location/presentation/locations_bloc/locations_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'common_widgets/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (_) => getIt<SettingsBloc>()
            ..add(LoadSettings(params: SettingsParams())),
        ),
        BlocProvider<CurrentLocationBloc>(
          create: (_) =>
              getIt<CurrentLocationBloc>()..add(const LoadCurrentLocation()),
        ),
        BlocProvider<CurrentWeatherBloc>(
          create: (_) => getIt<CurrentWeatherBloc>(),
        ),
        BlocProvider<ForecastWeatherBloc>(
          create: (_) => getIt<ForecastWeatherBloc>(),
        ),
        BlocProvider<FavoriteLocationsBloc>(
          create: (_) => getIt<FavoriteLocationsBloc>(),
        ),
        BlocProvider<LocationsBloc>(
          create: (_) => getIt<LocationsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: kTheme,
        darkTheme: kdarkTheme,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const TabsScreen(),
          SettingsPage.routeName: (ctx) => const SettingsPage(),
          LocationsPage.routeName: (ctx) => const LocationsPage(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: ((context) => const TabsScreen()));
        },
      ),
    );
  }
}
