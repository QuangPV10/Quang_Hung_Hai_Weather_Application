import 'package:flutter/material.dart';
import 'package:quang_hung_hai_weather_application/src/theme/app_theme.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../helper/day_format.dart';
import '../models/current_weather.dart';
import '../models/temp_hourly.dart';

class DayTempChart extends StatelessWidget {
  final List<DayWeather> weatherTempAlert;
  final CurrentWeather weather;
  final Color color;

  const DayTempChart(
      {required this.weather,
      required this.weatherTempAlert,
      required this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle labelOfChart = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.regular,
            fontSize: 13,
            color: Colors.white);
    return SfSparkBarChart.custom(
      labelStyle: labelOfChart,
      color: color,
      negativePointColor: Colors.red,
      labelDisplayMode: SparkChartLabelDisplayMode.all,
      dataCount: 25 - CustomDateTimeFormat.unixTimeToHour(weather.dateTime),
      xValueMapper: (index) => weatherTempAlert[index].datetime,
      yValueMapper: (index) => weatherTempAlert[index].temp.toInt(),
    );
  }
}
