import './weather.dart';

class DayWeather {
  late double temp;
  late int datetime;
  late Weather weather;

  DayWeather(
      {required this.temp, required this.datetime, required this.weather});

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    var weathersFromJson = json["weather"] as List<dynamic>;
    Weather weather = weathersFromJson.map((e) => Weather.fromJson(e)).first;
    return DayWeather(
        temp: json["temp"] - 273.15, datetime: json["dt"], weather: weather);
  }
}