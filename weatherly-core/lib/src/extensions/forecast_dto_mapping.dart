import '../dtos.dart';
import '../models.dart';
import '../network.dart';

/// Provides DTO mapping functionality.
extension ForecastDTOMapping on ForecastDto {
  /// Maps this DTO to a `Forecast` model instance.
  Forecast toForecast() {
    return Forecast(
      id: id,
      humidity: humidity,
      minTemp: minTemp?.toInt(),
      maxTemp: maxTemp?.toInt(),
      windSpeed: windSpeed?.toInt(),
      forecastDescription: weatherStateName,
      forecastIconURL:
          '${APIEndpoints.forecastSvgBaseUrl}/$weatherStateAbbr.svg',
      forecastDate: DateTime.now(), // TODO: Implement this.
    );
  }
}
