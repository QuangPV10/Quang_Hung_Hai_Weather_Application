class Weather {
  late String weather;
  late String weatherIcon;

  Weather({required this.weather, required this.weatherIcon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weather: json["main"],
      weatherIcon: json["icon"],
    );
  }
}