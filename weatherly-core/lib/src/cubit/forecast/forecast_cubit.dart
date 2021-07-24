import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models.dart';
import '../../services.dart';

/// Cubit responsible for retrieving `Forecast` information.
class ForecastCubit extends Cubit<ForecastState> {
  /// Forecast service.
  final ForecastService forecastService;

  /// Creates a new `ForecastCubit` instance with
  /// the provided locationId parameter.
  ForecastCubit({
    required int locationId,
    required this.forecastService,
  }) : super(ForecastState(locationId: locationId));

  /// Loads the `Forecast` data form the API.
  void load() async {
    emit(
      state.copyWith(
        busy: true,
        failed: false,
      ),
    );

    try {
      final forecasts = await forecastService.list(
        locationId: state.locationId,
      );
      emit(
        state.copyWith(
          forecasts: forecasts,
          busy: false,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          busy: false,
          failed: true,
        ),
      );
    }
  }

  /// Changes the location id and updates the cubit state.
  void changeLocationId(int locationId) {
    emit(
      state.copyWith(
        locationId: locationId,
      ),
    );
    load();
  }
}

/// Represents the state of `ForecastCubit`.
class ForecastState extends Equatable {
  /// Whether or not this cubit instance is busy.
  final bool busy;

  /// Whether or not this cubit failed when retrieving data.
  final bool failed;

  /// Unmodifiable list of forecast.
  final UnmodifiableListView<Forecast> forecasts;

  /// Current location ID this cubit retrieves data for.
  final int locationId;

  /// Creates a new `ForecastState` instance.
  ForecastState({
    required this.locationId,
    this.busy = false,
    this.failed = false,
    Iterable<Forecast> forecasts = const [],
  }) : forecasts = UnmodifiableListView(forecasts);

  @override
  List<Object?> get props => [
        busy,
        failed,
        forecasts,
        locationId,
      ];

  /// Creates a new instance of [ForecastState] based on the current instance.
  ForecastState copyWith({
    bool? busy,
    bool? failed,
    Iterable<Forecast>? forecasts,
    int? locationId,
  }) {
    return ForecastState(
      busy: busy ?? this.busy,
      failed: failed ?? this.failed,
      forecasts: forecasts ?? this.forecasts,
      locationId: locationId ?? this.locationId,
    );
  }
}
