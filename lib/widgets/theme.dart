// ignore_for_file: deprecated_member_use

import 'package:demoapp/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: MyAppBarTheme.lightAppBar,
    scaffoldBackgroundColor: MyAppColor.primaryColor,
    cardColor: MyAppColor.seondaryColor,
    primaryColor: MyAppColor.primaryColor,
    accentColor: MyAppColor.darkCanvasColor,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: MyAppBarTheme.darkAppBar,
    scaffoldBackgroundColor: MyAppColor.cardBgColor,
    cardColor: MyAppColor.cardBgColor,
    primaryColor: MyAppColor.seondaryColor,
    accentColor: MyAppColor.lightCanvasColor,
  );
}
