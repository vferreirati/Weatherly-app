import 'package:weatherly_core/src/DTOs/forecast_dto.dart';
import 'package:weatherly_core/src/models/forecast.dart';
import 'package:weatherly_core/src/network/api_endpoints.dart';

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
