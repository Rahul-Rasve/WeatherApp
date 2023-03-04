// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: yellowColor,
        body: SizedBox(
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
      ),
    );
  }
}
