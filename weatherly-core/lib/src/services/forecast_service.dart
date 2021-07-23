import 'package:dio/dio.dart';
import 'package:weatherly_core/src/DTOs/forecast_response_dto.dart';
import 'package:weatherly_core/src/extensions/forecast_dto_mapping.dart';
import 'package:weatherly_core/src/models/forecast.dart';
import 'package:weatherly_core/src/network/api_endpoints.dart';

/// Service responsible for retrieving `Forecast` related data.
class ForecastService {
  /// Creates a new `ForecastService` instance.
  const ForecastService();

  /// Retrieves the list of forecast for the provided location ID.
  Future<List<Forecast>> list({required int locationId}) async {
    final result = await Dio().get('${APIEndpoints.location}/$locationId');

    if (result.statusCode != 200 || result.data == null) return [];
    final response = ForecastResponseDto.fromJson(result.data);
    final forecasts = response.consolidatedWeather ?? [];

    return forecasts.map((x) => x.toForecast()).toList();
  }
}
