import 'package:flutter/material.dart';
import 'package:quang_hung_hai_weather_application/src/models/city.dart';

class WeatherForecastScreen extends StatelessWidget {
  final City city;
  const WeatherForecastScreen(this.city, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('latitude ' + city.coordinate.latitude.toString()),
            Text('longitude ' + city.coordinate.longitude.toString()),
          ],
        ),
      ),
    );
  }
}
