import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/ui_helpers/color_constants.dart';

class AppThemeData {
  static ThemeData get appTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme:
      TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
      ),
      colorScheme: const ColorScheme(
          primary: ColorConstants.primaryColor,
          surface: Colors.black,
          secondary: Colors.white,
          background: Colors.black,
          brightness: Brightness.dark,
          error: Colors.red,
          onBackground: Colors.black,
          onError: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black),
    );
  }
}
