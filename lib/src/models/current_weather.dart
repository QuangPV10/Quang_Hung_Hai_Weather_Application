import 'city.dart';

import 'temp_hourly.dart';
import 'weather.dart';

class CurrentWeather {
  late int dateTime;
  late num temp;
  late City? city;
  Weather weatherStatus;
  List<DayWeather> weatherHourlyAlerts;

  set setCity(City city) {
    this.city = city;
  }

  CurrentWeather(
      {required this.dateTime,
      required this.temp,
      required this.weatherStatus,
      required this.weatherHourlyAlerts});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    var weathersFromJson = json["current"]["weather"] as List<dynamic>;
    Weather weatherStatus =
        weathersFromJson.map((e) => Weather.fromJson(e)).first;
    var tempFromJson = json["hourly"] as List<dynamic>;
    List<DayWeather> tempHourlyList = <DayWeather>[];
    for (var element in tempFromJson) {
      DayWeather weather = DayWeather.fromJson(element);
      tempHourlyList.add(weather);
    }
    return CurrentWeather(
      dateTime: json["current"]["dt"],
      temp: json["current"]["temp"] - 273.15,
      weatherStatus: weatherStatus,
      weatherHourlyAlerts: tempHourlyList,
    );
  }
}
