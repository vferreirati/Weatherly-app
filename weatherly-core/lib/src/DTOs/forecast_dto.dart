/// Represents the forecast JSON object as retrieved from the API.
class ForecastDto {
  /// Id of this forecast.
  int? id;

  /// Humidity value of this forecast.
  int? humidity;

  /// The description of this forecast.
  String? weatherStateName;

  /// Abreviation of the forecast.
  /// Used to retrieve the forecast description icon.
  String? weatherStateAbbr;

  /// Date of the forecast.
  String? applicableDate;

  /// Minimal temperature of the forecast.
  double? minTemp;

  /// Max temperature of the forecast.
  double? maxTemp;

  /// Wind speed of this forecast.
  double? windSpeed;

  /// Creates a new `ForecastDto` instance
  ForecastDto({
    this.id,
    this.humidity,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.windSpeed,
  });

  /// Creates a new `ForecastDto` from a JSON map.
  factory ForecastDto.fromJson(Map<String, dynamic> map) {
    return ForecastDto(
      id: map['id'],
      humidity: map['humidity'],
      weatherStateName: map['weather_state_name'],
      weatherStateAbbr: map['weather_state_abbr'],
      applicableDate: map['applicable_date'],
      minTemp: map['min_temp'],
      maxTemp: map['max_temp'],
      windSpeed: map['wind_speed'],
    );
  }

  /// Creates a new `ForecastDto` list form a JSON map list.
  static List<ForecastDto> fromJsonList(List<Map<String, dynamic>> list) {
    return List<ForecastDto>.from(
      list.map((x) => ForecastDto.fromJson(x)).toList(),
    );
  }
}
