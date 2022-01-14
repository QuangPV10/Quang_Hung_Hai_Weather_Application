import './weather.dart';

class WeekWeather {
  late double tempMax;
  late double tempMin;
  late num dateTime;
  Weather weather;

  WeekWeather(
      {required this.tempMax,
      required this.tempMin,
      required this.dateTime,
      required this.weather});

  factory WeekWeather.fromJson(Map<String, dynamic> json) {
    var weathersFromJson = json["weather"] as List<dynamic>;
    Weather weather = weathersFromJson.map((e) => Weather.fromJson(e)).first;
    return WeekWeather(
      tempMax: json["temp"]['max'] - 273.15,
      tempMin: json["temp"]["min"] - 273.15,
      dateTime: json["dt"],
      weather: weather,
    );
  }
}
