import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import './constants/routes_name.dart';
import './routes/route_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: RouteNames.main,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteController().routePage,
    );
  }
}
