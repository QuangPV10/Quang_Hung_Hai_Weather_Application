import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/temp_daily.dart';
import '../theme/app_colors.dart';

class WeekTempChart extends StatefulWidget {
  final List<WeekWeather> item;
  const WeekTempChart({required this.item, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WeekTempChartState();
}

class WeekTempChartState extends State<WeekTempChart> {
  final Color leftBarColor = AppColors.maxTempChartColor.withOpacity(0.9);
  final Color rightBarColor = AppColors.tempMinChartColor.withOpacity(0.9);
  final double widthOfItem = 30;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    showingBarGroups = List.generate(
        widget.item.length,
        (index) => makeGroupData(
            tempMax: getTempMax(index), tempMin: getTempMin(index)));
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: false,
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingBarGroups,
        gridData: FlGridData(show: false),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      {required double tempMin, required double tempMax}) {
    return BarChartGroupData(
      x: tempMax.toInt(),
      barRods: [
        BarChartRodData(
            y: tempMax,
            colors: [leftBarColor],
            borderRadius: BorderRadius.zero,
            width: widthOfItem),
        BarChartRodData(
            y: tempMin,
            colors: [rightBarColor],
            borderRadius: BorderRadius.zero,
            width: widthOfItem),
      ],
    );
  }

  getTempMax(int i) {
    double tempMax = widget.item[i].tempMax;
    return tempMax;
  }

  getTempMin(int i) {
    double tempMin = widget.item[i].tempMin;
    return tempMin;
  }
}
