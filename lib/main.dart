// ignore_for_file: prefer_const_constructors

import 'package:demoapp/pages/splash.dart';
import 'package:demoapp/resources/auth.dart';
import 'package:demoapp/widgets/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(Auththentication()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,

      // routes
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
      },
    );
  }
}
