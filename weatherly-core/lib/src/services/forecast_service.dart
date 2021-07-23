import 'package:weatherly_core/src/DTOs/forecast_response_dto.dart';
import 'package:weatherly_core/src/extensions/forecast_dto_mapping.dart';
import 'package:weatherly_core/src/models/forecast.dart';
import 'package:weatherly_core/src/network/api_endpoints.dart';
import 'package:weatherly_core/src/network/netclient.dart';

/// Service responsible for retrieving `Forecast` related data.
class ForecastService {
  /// Netclient to be used by this service.
  final Netclient netclient;

  /// Creates a new `ForecastService` instance.
  const ForecastService({
    required this.netclient,
  });

  /// Retrieves the list of forecast for the provided location ID.
  Future<List<Forecast>> list({required int locationId}) async {
    final result = await netclient.get(
      path: '${APIEndpoints.location}/$locationId',
    );

    if (result.statusCode != 200 || result.data == null) return [];
    final response = ForecastResponseDto.fromJson(result.data);
    final forecasts = response.consolidatedWeather ?? [];

    return forecasts.map((x) => x.toForecast()).toList();
  }
}
