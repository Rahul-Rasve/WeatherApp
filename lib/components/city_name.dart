// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class CityName extends StatelessWidget {
  const CityName({
    super.key,
    this.cityName,
    required this.countryName,
  });

  final String? cityName;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '$cityName, ',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: blackColor,
            ),
          ),
          Text(
            countryName,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}