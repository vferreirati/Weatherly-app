import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final cubit = context.watch<ForecastCubit>();
    final state = cubit.state;

    final busy = state.busy;
    final failed = state.failed;
    final forecasts = state.forecasts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weatherly'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StateBuilder(
        onTryAgain: cubit.load,
        hasError: failed,
        isBusy: busy,
        child: ForecastList(
          forecasts: forecasts,
        ),
      ),
    );
  }
}
