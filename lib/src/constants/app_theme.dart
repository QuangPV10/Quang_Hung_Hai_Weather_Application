import 'package:flutter/material.dart';

import './app_colors.dart';

class AppFontWeight {
  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const ultraBold = FontWeight.w900;
}

class AppTheme {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: ColorsApp.backgroundColor,
    primaryColor: ColorsApp.backgroundBottomColor,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontSize: 25,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 18,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
        fontWeight: AppFontWeight.medium,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 15,
        fontWeight: AppFontWeight.regular,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 13,
        fontWeight: AppFontWeight.regular,
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 24.0,
    ),
  );
}
