// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_view.dart';
import 'package:weather_app/screens/weather_view.dart';

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
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/weather': (context) => WeatherPage(),
      },
    );
  }
}
