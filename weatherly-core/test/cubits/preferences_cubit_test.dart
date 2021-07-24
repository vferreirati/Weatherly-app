import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:weatherly_core/src/cubit/forecast/preferences_cubit.dart';
import 'package:weatherly_core/src/interfaces/app_storage.dart';
import 'package:weatherly_core/src/models.dart';

class _MockedAppStorage extends Mock implements AppStorage {}

late _MockedAppStorage _storage;

void main() {
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

  group('Success case', () {
    setUpAll(() {
      _storage = _MockedAppStorage();

      when(
        () => _storage.getInt(key: 'selected_location'),
      ).thenAnswer(
        (_) async => 44418,
      );
    });

    blocTest<PreferencesCubit, PreferencesState>(
      'Starts with empty state and initial location',
      build: () => PreferencesCubit(
        storage: _storage,
      ),
      verify: (c) => expect(
        c.state,
        PreferencesState(
          selectedLocation: const Location(
            id: 44418,
            name: 'London',
          ),
        ),
      ),
    );

    blocTest<PreferencesCubit, PreferencesState>(
      'Loads the selected location successfully',
      build: () => PreferencesCubit(
        storage: _storage,
      ),
      act: (c) => c.load(),
      expect: () => [
        PreferencesState(
          busy: true,
          selectedLocation: const Location(
            id: 44418,
            name: 'London',
          ),
        ),
        PreferencesState(
          busy: false,
          selectedLocation: const Location(
            id: 44418,
            name: 'London',
          ),
          availableLocations: defaultLocations,
        ),
      ],
      verify: (c) => verify(
        () => _storage.getInt(key: 'selected_location'),
      ).called(1),
    );
  });

  group('Failure case', () {
    setUpAll(() {
      _storage = _MockedAppStorage();

      when(
        () => _storage.getInt(key: 'selected_location'),
      ).thenThrow(
        Exception('ayy lmao!'),
      );
    });

    blocTest<PreferencesCubit, PreferencesState>(
      'Handles failure gracefully',
      build: () => PreferencesCubit(
        storage: _storage,
      ),
      act: (c) => c.load(),
      expect: () => [
        PreferencesState(
          busy: true,
          selectedLocation: const Location(
            id: 44418,
            name: 'London',
          ),
        ),
        PreferencesState(
          busy: false,
          selectedLocation: const Location(
            id: 44418,
            name: 'London',
          ),
          availableLocations: defaultLocations,
        ),
      ],
      verify: (c) => verify(
        () => _storage.getInt(key: 'selected_location'),
      ).called(1),
    );
  });

  group('Saving new location', () {
    setUpAll(() {
      _storage = _MockedAppStorage();

      when(
        () => _storage.getInt(key: 'selected_location'),
      ).thenAnswer(
        (_) async => 742676,
      );

      when(
        () => _storage.setInt(key: 'selected_location', value: 742676),
      ).thenAnswer((_) async => true);
    });

    blocTest<PreferencesCubit, PreferencesState>(
      'Set location saves the new location successfully',
      build: () => PreferencesCubit(
        storage: _storage,
      ),
      act: (c) {
        c.setLocation(
          const Location(
            id: 742676,
            name: 'Lisbon',
          ),
        );
      },
      expect: () => [
        PreferencesState(
          busy: true,
          selectedLocation: const Location(
            id: 44418,
            name: 'London',
          ),
        ),
        PreferencesState(
          busy: false,
          selectedLocation: const Location(
            id: 742676,
            name: 'Lisbon',
          ),
          availableLocations: defaultLocations,
        ),
      ],
      verify: (c) => verify(
        () => _storage.setInt(
          key: 'selected_location',
          value: 742676,
        ),
      ).called(1),
    );
  });
}
