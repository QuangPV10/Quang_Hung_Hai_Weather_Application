import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import './src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_config");
  await GlobalConfiguration().loadFromPath("assets/data/city_list.json");
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en', 'US'),
      child:  const MyApp(),
    ),
  );
}
