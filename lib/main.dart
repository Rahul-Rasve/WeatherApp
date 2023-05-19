// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mausam',
      home: SplashScreen(),
      theme: ThemeData(
        fontFamily: 'TiltNeon',
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.black, //bubble under the cursor
        ),
      ),
    );
  }
}
