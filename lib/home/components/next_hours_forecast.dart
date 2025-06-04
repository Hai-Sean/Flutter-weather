import 'package:flutter/material.dart';

import 'elements/next_hours_forecast_element.dart';

class NextHoursForecast extends StatelessWidget {
  const NextHoursForecast({
    super.key,
    required this.nextHoursForecastDesc,
    required this.nextHoursForecastData,
  });

  final String nextHoursForecastDesc;
  final List<List<String>> nextHoursForecastData;

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
          Text(nextHoursForecastDesc, textAlign: TextAlign.left),
          Divider(color: Colors.grey.shade500),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nextHoursForecastData.length,
              itemBuilder: (context, index) {
                var time = nextHoursForecastData[index][0];
                var iconUrl = nextHoursForecastData[index][1];
                var temp = nextHoursForecastData[index][2];
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