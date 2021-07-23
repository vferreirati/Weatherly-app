import 'package:equatable/equatable.dart';

/// Weather forecast object.
///
/// Contains all the data needed by the UI.
class Forecast extends Equatable {
  /// Id of this forecast.
  final int? id;

  /// Humidity value of this forecast.
  final int? humidity;

  /// Minimal temperature of the forecast.
  final int? minTemp;

  /// Max temperature of the forecast.
  final int? maxTemp;

  /// Wind speed of this forecast.
  final int? windSpeed;

  /// The description of this forecast.
  final String? forecastDescription;

  /// Icon URL of this forecast.
  final String? forecastIconURL;

  /// The date this forecast relates to.
  final DateTime? forecastDate;

  /// Creates a new `Forecast` instance.
  const Forecast({
    required this.id,
    required this.humidity,
    required this.forecastDescription,
    required this.forecastIconURL,
    required this.forecastDate,
    required this.minTemp,
    required this.maxTemp,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
        id,
        humidity,
        forecastDescription,
        forecastIconURL,
        forecastDate,
        minTemp,
        maxTemp,
        windSpeed,
      ];
}
