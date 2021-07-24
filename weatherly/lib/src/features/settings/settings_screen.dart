import 'package:flutter/material.dart';
import 'package:weatherly_core/weatherly_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The application settings screen.
class SettingsScreen extends StatelessWidget {
  /// Creates a new `SettingsScreen` instance.
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PreferencesCubit>();
    final state = cubit.state;
    final options = state.availableLocations;
    final selectedLocation = state.selectedLocation;

    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Location:',
              style: theme.bodyText1,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) => _LocationListTile(
                location: options[index],
                selectedId: selectedLocation.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationListTile extends StatelessWidget {
  final Location location;
  final int selectedId;

  const _LocationListTile({
    Key? key,
    required this.location,
    required this.selectedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.headline6;

    return RadioListTile<int>(
      title: Text(
        location.name,
        style: theme,
      ),
      groupValue: selectedId,
      value: location.id,
      onChanged: (_) => context.read<PreferencesCubit>().setLocation(location),
    );
  }
}
