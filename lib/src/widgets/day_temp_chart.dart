import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../constants/app_colors.dart';
import '../constants/app_theme.dart';
import '../helper/day_format.dart';
import '../models/current_weather.dart';
import '../models/temp_hourly.dart';

class DayTempChart extends StatelessWidget {
  final List<DayWeather> weatherTempAlert;
  final CurrentWeather weather;
  final Color color;

  DayTempChart(
      {required this.weather, required this.weatherTempAlert,required this.color, Key? key})
      : super(key: key);
  final AppTheme _theme = AppTheme();


  @override
  Widget build(BuildContext context) {
    TextStyle labelOfChart = _theme.lightTheme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
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
