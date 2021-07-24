import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherly_core/weatherly_core.dart';

import '../../extensions/date_time_ui_extension.dart';

/// Screen responsible for showing the remaining
/// `Forecast` information.
class ForecastDetailsScreen extends StatelessWidget {
  /// The `Forecast` this screen will work with.
  final Forecast forecast;

  /// Creates a new `ForecastDetailsScreen` instance with
  /// the provided `Forecast`.
  const ForecastDetailsScreen({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = forecast.forecastDate;
    final iconUrl = forecast.forecastIconURL;
    final minTemp = forecast.minTemp;
    final maxTemp = forecast.maxTemp;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date == null
                  ? 'N/A'
                  : date.isToday
                      ? 'Today'
                      : DateFormat('EEEE').format(
                          date,
                        ),
              style: theme.headline6,
            ),
            const SizedBox(
              height: 24.0,
            ),
            if (iconUrl != null)
              SvgPicture.network(
                iconUrl,
                height: 84,
                width: 84,
              ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              '$minTemp°/$maxTemp°',
              style: theme.headline6,
            ),
            const SizedBox(
              height: 48.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Humidity',
                  style: theme.headline6,
                ),
                Text(
                  '${forecast.humidity}%',
                  style: theme.headline6,
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Windspeed',
                  style: theme.headline6,
                ),
                Text(
                  '${forecast.windSpeed}mph',
                  style: theme.headline6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
