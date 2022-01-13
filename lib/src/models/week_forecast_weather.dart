import 'dart:core';
import 'temp_daily.dart';

class WeekForeCastWeather {
  late List<WeekWeather> listWeekWeather;

  WeekForeCastWeather({required this.listWeekWeather});

  factory WeekForeCastWeather.fromJson(Map<String, dynamic> json) {
    var tempFromJson = json["daily"] as List<dynamic>;
    List<WeekWeather> weekWeatherList = <WeekWeather>[];
    for (var element in tempFromJson) {
      WeekWeather weather = WeekWeather.fromJson(element);
      weekWeatherList.add(weather);
    }
    return WeekForeCastWeather(
      listWeekWeather: weekWeatherList,
    );
  }
}
