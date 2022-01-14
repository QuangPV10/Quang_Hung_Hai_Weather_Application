import 'package:flutter/material.dart';
import '../../models/city.dart';

class MainScreen extends StatelessWidget {
  final City city;
  const MainScreen(this.city, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
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
