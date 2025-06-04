import 'package:flutter/material.dart';

import '../../models/home_models/home_header_model.dart';

class CurrentTempHeaderView extends StatelessWidget {
  const CurrentTempHeaderView({super.key, required this.model});

  final HomeHeaderModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(model.currentLocationName, style: TextStyle(fontSize: 37)),
          Text(
            model.currentTemp,
            style: TextStyle(
              fontSize: 90,
              fontWeight: FontWeight.w200,
              height: 1,
            ),
          ),
          Text(model.currentWeatherType, style: TextStyle(fontSize: 24)),
          Text(model.currentHighLowTemp, style: TextStyle(fontSize: 21)),
        ],
      ),
    );
  }
}
