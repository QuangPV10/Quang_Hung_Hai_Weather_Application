import 'package:flutter/material.dart';

import './src/app.dart';
import './src/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().initialize();
  runApp(const MyApp());
}
