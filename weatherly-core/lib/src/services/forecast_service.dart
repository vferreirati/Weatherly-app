import '../dtos.dart';
import '../extensions.dart';
import '../models.dart';
import '../network.dart';

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
