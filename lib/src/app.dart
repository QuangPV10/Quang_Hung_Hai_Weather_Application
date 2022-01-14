import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/screens/main_screen/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:quang_hung_hai_weather_application/src/services/weather/weather_service.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather/weather_service_implement.dart';
import './constants/routes_name.dart';
import './routes/route_controller.dart';
import 'blocs/weather/weather_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (conetext) => WeatherBloc(service: WeatherServiceImplement()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.main,
        onGenerateRoute: RouteController().routePage,
      ),
    );
  }
}
