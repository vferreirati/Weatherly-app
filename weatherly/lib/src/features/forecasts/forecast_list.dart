import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/src/features/forecast_details/forecast_details_screen.dart';
import 'package:weatherly_core/weatherly_core.dart';

import '../../extensions/date_time_ui_extension.dart';

/// Widget responsible for listing the provided forecasts.
class ForecastList extends StatelessWidget {
  /// List of forecasts to be displayed.
  final List<Forecast> forecasts;

  /// Creates a new `ForecastList` instance.
  const ForecastList({
    Key? key,
    this.forecasts = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'London',
            style: Theme.of(context).textTheme.headline5,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: forecasts.length,
              itemBuilder: (context, index) => _ForecastListItem(
                forecast: forecasts[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastListItem extends StatelessWidget {
  final Forecast forecast;
  const _ForecastListItem({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = forecast.forecastDate;
    final minTemp = forecast.minTemp;
    final maxTemp = forecast.maxTemp;
    final forecastIconUrl = forecast.forecastIconURL;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ForecastDetailsScreen(
              forecast: forecast,
            ),
          ),
        ),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    date == null
                        ? 'N/A'
                        : date.isToday
                            ? 'Today'
                            : DateFormat('EEEE').format(
                                date,
                              ),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Text('$minTemp°/$maxTemp°'),
                const SizedBox(
                  width: 24.0,
                ),
                if (forecastIconUrl != null)
                  SvgPicture.network(
                    forecastIconUrl,
                    height: 24.0,
                    width: 24.0,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
