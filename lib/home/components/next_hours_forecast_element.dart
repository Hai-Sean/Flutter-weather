import 'package:flutter/material.dart';

class NextHoursForecastElement extends StatelessWidget {
  String time;
  String iconUrl;
  String temp;

  NextHoursForecastElement({
    super.key,
    required this.time,
    required this.iconUrl,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(time),
          Image(image: NetworkImage(iconUrl)),
          Text(temp, style: TextStyle(fontSize: 22),)
        ],
      ),
    );
  }
}
