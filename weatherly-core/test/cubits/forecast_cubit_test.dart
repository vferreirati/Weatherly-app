import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:weatherly_core/weatherly_core.dart';
import 'package:test/test.dart';

class _MockForecastService extends Mock implements ForecastService {}

late _MockForecastService _service;

const _loadForecastId = 100;
const _throwsExceptionId = 200;
const _changedLocationId = 300;

void main() {
  final mockedForecasts = List.generate(
    20,
    (index) => Forecast(
      id: index,
      forecastDate: DateTime.now(),
      forecastDescription: '',
      forecastIconURL: '',
      humidity: 0,
      maxTemp: 0,
      minTemp: 0,
      windSpeed: 0,
    ),
  );

  setUp(() {
    _service = _MockForecastService();

    when(
      () => _service.list(locationId: _loadForecastId),
    ).thenAnswer(
      (_) async => mockedForecasts,
    );

    when(
      () => _service.list(locationId: _changedLocationId),
    ).thenAnswer(
      (_) async => mockedForecasts,
    );

    when(
      () => _service.list(locationId: _throwsExceptionId),
    ).thenThrow(
      Exception('Ayy lmao!'),
    );
  });

  blocTest<ForecastCubit, ForecastState>(
    'Starts with empty state',
    build: () => ForecastCubit(
      locationId: _loadForecastId,
      forecastService: _service,
    ),
    verify: (c) => expect(
      c.state,
      ForecastState(
        locationId: _loadForecastId,
      ),
    ),
  );

  blocTest<ForecastCubit, ForecastState>(
    'Loads forecasts successfully',
    build: () => ForecastCubit(
      locationId: _loadForecastId,
      forecastService: _service,
    ),
    expect: () => [
      ForecastState(
        locationId: _loadForecastId,
        busy: true,
      ),
      ForecastState(
        locationId: _loadForecastId,
        busy: false,
        forecasts: mockedForecasts,
      ),
    ],
    act: (c) => c.load(),
    verify: (c) => verify(
      () => _service.list(locationId: _loadForecastId),
    ).called(1),
  );

  blocTest<ForecastCubit, ForecastState>(
    'Handles exceptions gracefully',
    build: () => ForecastCubit(
      locationId: _throwsExceptionId,
      forecastService: _service,
    ),
    act: (c) => c.load(),
    expect: () => [
      ForecastState(
        locationId: _throwsExceptionId,
        busy: true,
      ),
      ForecastState(
        locationId: _throwsExceptionId,
        busy: false,
        failed: true,
      ),
    ],
    verify: (c) => verify(
      () => _service.list(locationId: _throwsExceptionId),
    ).called(1),
  );

  blocTest<ForecastCubit, ForecastState>(
    'Changes the location ID successfully',
    build: () => ForecastCubit(
      locationId: _loadForecastId,
      forecastService: _service,
    ),
    act: (c) {
      c.changeLocationId(_changedLocationId);
    },
    expect: () => [
      ForecastState(
        locationId: _changedLocationId,
        busy: false,
      ),
      ForecastState(
        locationId: _changedLocationId,
        busy: true,
      ),
      ForecastState(
        locationId: _changedLocationId,
        forecasts: mockedForecasts,
      ),
    ],
    verify: (c) => verify(
      () => _service.list(locationId: _changedLocationId),
    ).called(1),
  );
}
