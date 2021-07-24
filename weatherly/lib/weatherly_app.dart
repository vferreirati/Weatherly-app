import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/src/features/forecasts/forecasts_screen.dart';
import 'src/storage/mobile_storage.dart';
import 'package:weatherly_core/weatherly_core.dart';

/// The Weatherly application!
/// Wohooo!
class WeatherlyApp extends StatelessWidget {
  /// Service responsible for retrieving `Forecast` related data.
  final ForecastService forecastService;

  /// Mobile storage implementation
  final MobileStorage storage;

  /// Creates a new `WeatherlyApp` instance.
  const WeatherlyApp({
    Key? key,
    required this.forecastService,
    required this.storage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreferencesCubit>(
      create: (context) => PreferencesCubit(
        storage: storage,
      )..load(),
      child: MaterialApp(
        home: BlocProvider<ForecastCubit>(
          create: (context) {
            final id =
                context.read<PreferencesCubit>().state.selectedLocation.id;
            return ForecastCubit(
              forecastService: forecastService,
              locationId: id,
            )..load();
          },
          child: const ForecastsScreen(),
        ),
      ),
    );
  }
}
