import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/home/components/next_hours_forecast_element.dart';
import 'package:weather_app/home/components/ten_days_forecast_element.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var comViewDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey.shade500.withOpacity(0.3),
    );

    var currentLocationName = 'Hanoi';
    var currentTemp = '21°';
    var currentWeatherType = 'Partly Cloudy';
    var currentHighLowTemp = 'H:29°  L:15°';

    var nextHoursForeCastDesc =
        'Cloudy conditions from 1AM-9AM, with showers expected at 9AM.';
    var mockWeatherIcon =
        'https://cdn.weatherapi.com/weather/64x64/day/122.png';
    // TODO: - Convert to model
    var nextHoursForecastDataMock = [
      ['Now', mockWeatherIcon, '21°'],
      ['1', mockWeatherIcon, '21°'],
      ['2', mockWeatherIcon, '21°'],
      ['3', mockWeatherIcon, '21°'],
      ['4', mockWeatherIcon, '21°'],
      ['5', mockWeatherIcon, '21°'],
      ['6', mockWeatherIcon, '21°'],
      ['7', mockWeatherIcon, '21°'],
      ['8', mockWeatherIcon, '21°'],
      ['9', mockWeatherIcon, '21°'],
      ['10', mockWeatherIcon, '21°'],
      ['11', mockWeatherIcon, '21°'],
      ['12', mockWeatherIcon, '21°'],
      ['13', mockWeatherIcon, '21°'],
      ['14', mockWeatherIcon, '21°'],
    ];

    var tenDaysForecastTitle = '10-DAY  FORECAST';
    var tenDaysForecastData = [
      ['Today', mockWeatherIcon, '23°', '30°'],
      ['Mon', mockWeatherIcon, '23°', '30°'],
      ['Tue', mockWeatherIcon, '23°', '30°'],
      ['Wed', mockWeatherIcon, '23°', '30°'],
      ['Thu', mockWeatherIcon, '23°', '30°'],
      ['Fri', mockWeatherIcon, '23°', '30°'],
      ['Sat', mockWeatherIcon, '23°', '30°'],
      ['Sun', mockWeatherIcon, '23°', '30°'],
      ['Mon', mockWeatherIcon, '23°', '30°'],
      ['Tue', mockWeatherIcon, '23°', '30°'],
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/bg_cloudy.jpg'),
              ),
            ),
          ),
          Center(
            child: ListView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 34),
                CurrentTempHeaderView(
                  currentLocationName: currentLocationName,
                  currentTemp: currentTemp,
                  currentWeatherType: currentWeatherType,
                  currentHighLowTemp: currentHighLowTemp,
                ),
                SizedBox(height: 44),
                NextHoursForecast(
                  nextHoursForecastDesc: nextHoursForeCastDesc,
                  nextHoursForecastDataMock: nextHoursForecastDataMock,
                ),
                TenDaysForecast(
                  tenDaysForecastTitle: tenDaysForecastTitle,
                  tenDaysForecastData: tenDaysForecastData,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
          Divider(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: tenDaysForecastData.length,
            itemBuilder: (context, index) {
              return TenDaysForecastElement(models: tenDaysForecastData[index]);
            },
          ),
        ],
      ),
    );
  }
}

class NextHoursForecast extends StatelessWidget {
  const NextHoursForecast({
    super.key,
    required this.nextHoursForecastDesc,
    required this.nextHoursForecastDataMock,
  });

  final String nextHoursForecastDesc;
  final List<List<String>> nextHoursForecastDataMock;

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
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nextHoursForecastDataMock.length,
              itemBuilder: (context, index) {
                var time = nextHoursForecastDataMock[index][0];
                var iconUrl = nextHoursForecastDataMock[index][1];
                var temp = nextHoursForecastDataMock[index][2];
                return NextHoursForecastElement(
                  time: time,
                  iconUrl: iconUrl,
                  temp: temp,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
          Text(
            currentLocationName,
            style: TextStyle(
              fontSize: 37,
            ),
          ),
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
