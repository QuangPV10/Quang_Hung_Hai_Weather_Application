import 'package:flutter/material.dart';

import './constants/routes_name.dart';
import './routes/route_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.location,
      onGenerateRoute: RouteController().routePage,
    );
  }
}
