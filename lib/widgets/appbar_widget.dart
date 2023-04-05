import 'package:flutter/material.dart';

class MyAppBarTheme {
  static AppBarTheme lightAppBar = const AppBarTheme(
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 16.8),
  );
  static AppBarTheme darkAppBar = const AppBarTheme(
    color: Colors.black,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 16.8),
  );
}
