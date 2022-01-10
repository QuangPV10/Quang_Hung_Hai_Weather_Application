import 'package:flutter/material.dart';

class WeatherForecastScreen extends StatelessWidget {
  final String cityName;
  const WeatherForecastScreen(this.cityName, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Center(
        child: Text(cityName),
      ),
    );
  }
}
