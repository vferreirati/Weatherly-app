import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/src/features/forecasts/forecasts_screen.dart';
import 'package:weatherly_core/weatherly_core.dart';

/// The Weatherly application!
/// Wohooo!
class WeatherlyApp extends StatelessWidget {
  /// Service responsible for retrieving `Forecast` related data.
  final ForecastService forecastService;

  /// Creates a new `WeatherlyApp` instance.
  const WeatherlyApp({
    Key? key,
    required this.forecastService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForecastCubit>(
      create: (context) => ForecastCubit(
        forecastService: forecastService,
        // TODO: Retrieve this from preferences.
        locationId: 44418,
      )..load(),
      child: const MaterialApp(
        home: ForecastsScreen(),
      ),
    );
  }
}
