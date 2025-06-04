import 'package:flutter/material.dart';

import '../../models/home_models/home_next_hours_model.dart';
import 'elements/next_hours_forecast_element.dart';

class NextHoursForecast extends StatelessWidget {
  const NextHoursForecast({super.key, required this.model});

  final HomeNextHoursModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade400.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Text(model.nextHoursForecastDesc, textAlign: TextAlign.left),
          Divider(color: Colors.grey.shade500),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.nextHoursForecastData.length,
              itemBuilder: (context, index) {
                var time = model.nextHoursForecastData[index].time;
                var iconUrl = model.nextHoursForecastData[index].iconUrlString;
                var temp = model.nextHoursForecastData[index].temp;
                return SizedBox(
                  height: 110,
                  width: 80,
                  child: NextHoursForecastElement(
                    time: time,
                    iconUrl: iconUrl,
                    temp: temp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
