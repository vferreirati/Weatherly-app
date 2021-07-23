/// Holds all necessary API endpoints.
class APIEndpoints {
  APIEndpoints._();

  /// Base url of the API.
  static const String baseUrl = 'https://www.metaweather.com';

  /// Location endpoint.
  static const String location = '/api/location';

  /// Forecast icon base URL.
  static const String forecastSvgBaseUrl = '$baseUrl/static/img/weather';
}
