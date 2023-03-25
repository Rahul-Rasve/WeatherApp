// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants.dart';

class DateDisplay extends StatelessWidget {
  const DateDisplay({
    super.key,
    required this.today,
  });

  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 150.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Text(
          DateFormat.MMMEd().format(today),
          style: TextStyle(
            fontSize: 20.0,
            color: yellowColor,
          ),
        ),
      ),
    );
  }
}