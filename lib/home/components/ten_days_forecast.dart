import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../conditions/conditions_page.dart';
import '../../models/home_models/home_ten_days_model.dart';
import 'elements/ten_days_forecast_element.dart';

class TenDaysForecast extends StatelessWidget {
  const TenDaysForecast({super.key, required this.model});

  final HomeTenDaysModel model;

  int getHighestTemp() {
    final maxTemp =
        model.tenDaysForecastData
            .map<int>((dayData) => dayData.maxTemp)
            .toList()
            .max;

    return maxTemp;
  }

  int getLowestTemp() {
    final minTemp =
        model.tenDaysForecastData
            .map<int>((dayData) => dayData.minTemp)
            .toList()
            .min;

    return minTemp;
  }

  @override
  Widget build(BuildContext context) {
    void presentConditionsScreen() {
      Navigator.of(context).push(
        CupertinoPageRoute(
          fullscreenDialog: false,
          builder: (context) => ConditionsPage(),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade400.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.white.withOpacity(0.8)),
              SizedBox(width: 10),
              Text(model.tenDaysForecastTitle, textAlign: TextAlign.left),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: model.tenDaysForecastData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: TenDaysForecastElement(
                  models: model.tenDaysForecastData[index],
                  maxC: getHighestTemp(),
                  minC: getLowestTemp(),
                ),
                onTap: () => presentConditionsScreen,
              );
            },
          ),
        ],
      ),
    );
  }
}

extension FancyIterable on Iterable<int> {
  int get max => reduce(math.max);

  int get min => reduce(math.min);
}
