// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class AdditionalInfoCard extends StatelessWidget {
  final String value;
  final String name;
  final IconData iconValue;

  const AdditionalInfoCard({
    super.key,
    required this.value,
    required this.iconValue,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconValue,
          color: yellowColor,
          size: 45.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'TiltNeon',
            fontWeight: FontWeight.w600,
            color: yellowColor,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'TiltNeon',
            fontWeight: FontWeight.w500,
            color: yellowColor,
          ),
        ),
      ],
    );
  }
}
