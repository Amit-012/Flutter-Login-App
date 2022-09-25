import 'package:demoapp/pages/home_page.dart';
import 'package:demoapp/pages/login_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: "/Home",
      routes: {
        "/": (context) => const LoginPage(),
        "/Home": (context) => const HomePage(),
        "/Login": (context) => const LoginPage()
      },
    );
  }
}
