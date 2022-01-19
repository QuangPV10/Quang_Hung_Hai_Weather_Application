import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './constants/routes_name.dart';
import './routes/route_controller.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.buildTheme(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: RouteNames.main,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteController().routePage,
    );
  }
}
