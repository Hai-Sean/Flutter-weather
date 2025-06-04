import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../conditions/conditions_page.dart';
import 'elements/ten_days_forecast_element.dart';

class TenDaysForecast extends StatelessWidget {
  const TenDaysForecast({
    super.key,
    required this.tenDaysForecastTitle,
    required this.tenDaysForecastData,
  });

  final String tenDaysForecastTitle;
  final List<List<String>> tenDaysForecastData;

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
              Text(tenDaysForecastTitle, textAlign: TextAlign.left),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: tenDaysForecastData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: TenDaysForecastElement(
                  models: tenDaysForecastData[index],
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