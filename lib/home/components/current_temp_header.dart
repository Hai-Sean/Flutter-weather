import 'package:flutter/material.dart';

class CurrentTempHeaderView extends StatelessWidget {
  const CurrentTempHeaderView({
    super.key,
    required this.currentLocationName,
    required this.currentTemp,
    required this.currentWeatherType,
    required this.currentHighLowTemp,
  });

  final String currentLocationName;
  final String currentTemp;
  final String currentWeatherType;
  final String currentHighLowTemp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(currentLocationName, style: TextStyle(fontSize: 37)),
          Text(
            currentTemp,
            style: TextStyle(
              fontSize: 90,
              fontWeight: FontWeight.w200,
              height: 1,
            ),
          ),
          Text(currentWeatherType, style: TextStyle(fontSize: 24)),
          Text(currentHighLowTemp, style: TextStyle(fontSize: 21)),
        ],
      ),
    );
  }
}