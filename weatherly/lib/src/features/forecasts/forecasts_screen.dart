import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/src/features/settings/settings_screen.dart';
import 'package:weatherly/src/widgets/state_builder.dart';
import 'package:weatherly_core/weatherly_core.dart';

import 'forecast_list.dart';

/// Screen responsible for showing the forecast for the next few days.
class ForecastsScreen extends StatelessWidget {
  /// Creates a new `ForecastsScreen` instance.
  const ForecastsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.watch<PreferencesCubit>();
    final selectedLocation = preferencesCubit.state.selectedLocation;
    final locationName = selectedLocation.name;

    final forecastCubit = context.watch<ForecastCubit>();
    final state = forecastCubit.state;

    final busy = state.busy;
    final failed = state.failed;
    final forecasts = state.forecasts;

    return BlocListener<PreferencesCubit, PreferencesState>(
      listenWhen: (oldState, newState) =>
          oldState.selectedLocation != newState.selectedLocation,
      listener: (_, newState) => forecastCubit.changeLocationId(
        newState.selectedLocation.id,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weatherly'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              ),
            ),
          ],
        ),
        body: StateBuilder(
          onTryAgain: forecastCubit.load,
          hasError: failed,
          isBusy: busy,
          child: ForecastList(
            locationName: locationName,
            forecasts: forecasts,
          ),
        ),
      ),
    );
  }
}
