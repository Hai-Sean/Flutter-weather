import 'package:flutter/material.dart';

import '../../../models/home_models/home_ten_days_model.dart';

class TenDaysForecastElement extends StatelessWidget {
  HomeTenDaysDataModel models;
  int maxC;
  int minC;

  TenDaysForecastElement({
    super.key,
    required this.models,
    required this.maxC,
    required this.minC,
  });

  @override
  Widget build(BuildContext context) {
    var day = models.dateString;
    var iconUrl = models.iconUrlString;
    var lowTemp = models.minTemp;
    var highTemp = models.maxTemp;

    final tempRange = maxC - minC;
    final lowTempGap = lowTemp - minC;
    final highTempGap = maxC - highTemp;
    final leftGradientValue = (lowTempGap / tempRange).toDouble();
    final rightGradientValue = 1 - (highTempGap / tempRange).toDouble();
    final tempRangeViewWidth = 100;

    final gradientLeftPadding = (lowTempGap / tempRange) * tempRangeViewWidth;
    final gradientRightPadding = (highTempGap / tempRange) * tempRangeViewWidth;

    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(color: Colors.grey.shade500),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textFormated(text: day),
              Spacer(),
              SizedBox(width: 40, child: Image(image: NetworkImage(iconUrl))),
              SizedBox(width: 16),
              _textFormated(text: '$lowTemp°'),
              SizedBox(width: 8),
              Container(
                width: tempRangeViewWidth.toDouble(),
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.black.withAlpha(80),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    gradientLeftPadding,
                    0,
                    gradientRightPadding,
                    0,
                  ),
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFFF00),
                        const Color(0xFFFF0000),
                      ],
                      // TODO: - re-calculate gradient properties
                      begin: FractionalOffset(leftGradientValue, 0.0),
                      end: FractionalOffset(rightGradientValue, 0.0),
                      stops: [0.0, 50.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              _textFormated(text: '$highTemp°'),
            ],
          ),
        ],
      ),
    );
  }
}

class _textFormated extends StatelessWidget {
  const _textFormated({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 22));
  }
}
