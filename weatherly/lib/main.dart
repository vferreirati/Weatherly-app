import 'package:flutter/cupertino.dart';
import 'package:weatherly/weatherly_app.dart';
import 'package:weatherly_core/weatherly_core.dart';

void main() {
  final netclient = Netclient(baseUrl: APIEndpoints.baseUrl);

  final forecastService = ForecastService(netclient: netclient);

  runApp(
    WeatherlyApp(
      forecastService: forecastService,
    ),
  );
}
