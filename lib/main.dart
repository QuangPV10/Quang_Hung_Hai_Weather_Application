import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import './src/app.dart';
import './src/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_config");
  await EasyLocalization.ensureInitialized();
  await AppConfig().initialize();
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
