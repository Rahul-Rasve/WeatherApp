// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({
    super.key,
    required this.tempC,
  });

  final String? tempC;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$tempC',
          style: TextStyle(
            fontSize: 150.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 0.0, 0.0),
          child: Text(
            'O',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: Text(
            'C',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
