import 'package:flutter/material.dart';

import '../models/forecast_response.dart';

class ConditionsPage extends StatelessWidget {
  ConditionsPage({super.key, required this.response});

  ForecastResponse? response;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/bg_partly_cloud.jpg')
            ),
          ),
        ),
        Center(
          child: Text(response?.current.condition.weatherText ?? ''),
        )
      ],
    );
  }
}
