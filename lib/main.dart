import 'package:flutter/material.dart';
import 'src/config/app_config.dart';

import 'src/app.dart';

void main() async {
  await AppConfig().initialize();
  runApp(const MyApp());
}
