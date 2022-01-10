import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/location/location_bloc.dart';
import './constants/routes_name.dart';
import './routes/route_controller.dart';
import './services/location/location_impl.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc(service: LocationImpl()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.location,
        onGenerateRoute: RouteController().routePage,
      ),
    );
  }
}
