// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/widgets/additional_info_card.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    super.key,
    required this.windValue,
    required this.humidityValue,
  });

  final String? windValue;
  final String? humidityValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AdditionalInfoCard(
              value: '$windValue km/h',
              iconValue: Icons.wind_power_outlined,
              name: 'Wind',
            ),
            AdditionalInfoCard(
              value: '$humidityValue%',
              iconValue: Icons.water_drop_outlined,
              name: 'Humidity',
            ),
          ],
        ),
      ),
    );
  }
}
