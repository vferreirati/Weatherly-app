import 'package:flutter/cupertino.dart';
import 'package:weatherly/src/storage/mobile_storage.dart';
import 'package:weatherly/weatherly_app.dart';
import 'package:weatherly_core/weatherly_core.dart';

void main() {
  final netclient = Netclient(baseUrl: APIEndpoints.baseUrl);

  final forecastService = ForecastService(netclient: netclient);
  final storage = MobileStorage();

  runApp(
    WeatherlyApp(
      forecastService: forecastService,
      storage: storage,
    ),
  );
}
