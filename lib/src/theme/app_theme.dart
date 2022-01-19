import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      fontFamily: 'Helvetica Neue',
      backgroundColor: ColorsApp.backgroundColor,
      primaryColor: ColorsApp.backgroundBottomColor,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 96,
          fontWeight: AppFontWeight.light,
          color: Colors.black,
        ),
        headline2: TextStyle(
          fontSize: 60,
          fontWeight: AppFontWeight.light,
          color: Colors.black,
        ),
        headline3: TextStyle(
          fontSize: 48,
          fontWeight: AppFontWeight.regular,
          color: Colors.black,
        ),
        headline4: TextStyle(
          fontSize: 34,
          fontWeight: AppFontWeight.bold,
          color: Colors.black,
        ),
        headline5: TextStyle(
          fontSize: 24,
          fontWeight: AppFontWeight.bold,
          color: Colors.black,
        ),
        headline6: TextStyle(
          fontSize: 20,
          fontWeight: AppFontWeight.bold,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.regular,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: AppFontWeight.light,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.regular,
          color: Colors.black,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: AppFontWeight.regular,
          color: Colors.black,
        ),
        button: TextStyle(
          fontSize: 14,
          fontWeight: AppFontWeight.medium,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: AppFontWeight.regular,
        ),
        overline: TextStyle(
          fontSize: 10,
          fontWeight: AppFontWeight.regular,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 24.0,
      ),
    );
  }
}

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
