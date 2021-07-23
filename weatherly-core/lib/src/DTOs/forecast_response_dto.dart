import '../dtos.dart';

/// Represents the response JSON object when retrieving
/// the weather forecast from the API.
class ForecastResponseDto {
  /// The list of forecasts.
  final List<ForecastDto>? consolidatedWeather;

  /// Creates a new `ForecastResponseDto` instance.
  ForecastResponseDto({
    this.consolidatedWeather,
  });

  /// Creates a new `ForecastResponseDto` from a JSON map.
  factory ForecastResponseDto.fromJson(Map<String, dynamic> map) {
    return ForecastResponseDto(
      consolidatedWeather: List<ForecastDto>.from(
        map['consolidated_weather']?.map(
          (x) => ForecastDto.fromJson(x),
        ),
      ),
    );
  }
}
