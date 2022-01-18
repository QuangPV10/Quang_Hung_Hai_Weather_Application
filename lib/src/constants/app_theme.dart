import 'package:flutter/material.dart';

import 'app_colors.dart';

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

class AppFont {
  static const String fontHelveticaNeue = "Helvetica Neue";
}

class AppTheme {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: ColorsApp.backgroundColor,
    primaryColor: ColorsApp.backgroundBottomColor,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 28,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 25,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 20,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 18,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 15,
        fontWeight: AppFontWeight.regular,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 15,
        fontWeight: AppFontWeight.light,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontFamily: AppFont.fontHelveticaNeue,
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
