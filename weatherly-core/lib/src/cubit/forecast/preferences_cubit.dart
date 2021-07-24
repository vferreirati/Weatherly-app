import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherly_core/src/interfaces/app_storage.dart';

import '../../models.dart';

/// Cubit responsible for retrieving the user preferences.
class PreferencesCubit extends Cubit<PreferencesState> {
  /// The storage to retrieve the preferences from.
  final AppStorage storage;

  /// Creates a new `PreferencesCubit` instance
  PreferencesCubit({
    required this.storage,
  }) : super(
          PreferencesState(
            selectedLocation: Location(
              id: 44418,
              name: 'London',
            ),
          ),
        );

  /// Loads the available locations list and the currently selected location
  ///
  /// Defaults the currently selected location to the first element of the list
  /// if no selection was made previously.
  void load() async {
    emit(
      state.copyWith(
        busy: true,
      ),
    );
    const defaultLocations = [
      Location(
        id: 44418,
        name: 'London',
      ),
      Location(
        id: 2487889,
        name: 'San Diego',
      ),
      Location(
        id: 742676,
        name: 'Lisbon',
      ),
    ];

    try {
      final selectedLocationId = await storage.getInt(
        key: 'selected_location',
      );
      final selectedLocation = defaultLocations.firstWhere(
        (x) => x.id == selectedLocationId,
        orElse: () => defaultLocations.first,
      );
      emit(
        state.copyWith(
          busy: false,
          availableLocations: defaultLocations,
          selectedLocation: selectedLocation,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          busy: false,
          availableLocations: defaultLocations,
          selectedLocation: defaultLocations.first,
        ),
      );
    }
  }

  void setLocation(Location location) async {
    await storage.setInt(
      key: 'selected_location',
      value: location.id,
    );
    load();
  }
}

/// Represents the `PreferencesCubit` state.
class PreferencesState extends Equatable {
  /// Whether or not this cubit is busy.
  final bool busy;

  /// List of available locations to retrieve forecasts.
  final UnmodifiableListView<Location> availableLocations;

  /// The currently selected location.
  final Location selectedLocation;

  /// Creates a new `PreferencesState` instance.
  PreferencesState({
    required this.selectedLocation,
    this.busy = false,
    Iterable<Location> availableLocations = const [],
  }) : availableLocations = UnmodifiableListView(availableLocations);

  @override
  List<Object?> get props => [
        busy,
        availableLocations,
        selectedLocation,
      ];

  /// Creates a new `PreferencesState` based on the current instance.
  PreferencesState copyWith({
    bool? busy,
    Iterable<Location>? availableLocations,
    Location? selectedLocation,
  }) {
    return PreferencesState(
      busy: busy ?? this.busy,
      availableLocations: availableLocations ?? this.availableLocations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
    );
  }
}
