import 'package:flutter/material.dart';

import '../models/forecast_response.dart';

class ConditionsPage extends StatelessWidget {
  ConditionsPage({super.key, required this.response});

  ForecastResponse? response;

  @override
  Widget build(BuildContext context) {
    return Text(response?.current.condition.weatherText ?? '');
  }
}
