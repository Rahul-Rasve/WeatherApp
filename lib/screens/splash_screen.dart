// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/weather_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
    ).then((value) => Navigator.pushNamedAndRemoveUntil(
        context, '/weather', (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/weather general.png'),
                ),
              ),
            ),
          ),
        ),
        duration: 1000,
        animationDuration: Duration(milliseconds: 800),
        splashIconSize: 300,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: yellowColor,
        nextScreen: WeatherPage(),
      ),
    );
  }
}
