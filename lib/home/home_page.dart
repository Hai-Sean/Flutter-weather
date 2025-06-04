import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/services/weather_repo.dart';
import 'package:intl/intl.dart';

import 'components/current_temp_header.dart';
import 'components/next_hours_forecast.dart';
import 'components/ten_days_forecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ForecastResponse? forecastResponse;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    // fetch remote data
    getWeatherForecast();
  }

  getWeatherForecast() async {
    forecastResponse = await WeatherRepo().getWeatherForecast();
    if (forecastResponse != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var comViewDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey.shade500.withOpacity(0.3),
    );

    var isDay = forecastResponse?.current.isDay == 1;
    var currentLocationName = forecastResponse?.location.name ?? '';
    var currentTemp = '${(forecastResponse?.current.tempC)?.toInt()}°';
    var currentWeatherType =
        forecastResponse?.current.condition.weatherText ?? '';
    var todayMaxTemp =
        forecastResponse?.forecast.forecastday.first.day.maxtempC;
    var todayMinTemp =
        forecastResponse?.forecast.forecastday.first.day.mintempC;
    var currentHighLowTemp =
        'H:${'$todayMaxTemp°' ?? ''}   L:${'$todayMinTemp°' ?? ''}';

    // TODO: - Remove mock forecast desc
    final nextHoursForeCastDesc =
        'Cloudy conditions from 1AM-9AM, with showers expected at 9AM.';

    final twoDayHoursForecastResponse =
        forecastResponse!.forecast.forecastday.first.hour +
        forecastResponse!.forecast.forecastday[1].hour;

    final hourInt = int.parse(DateFormat.H().format(DateTime.now()));

    List<List<String>> nextHoursForecastData =
        twoDayHoursForecastResponse
            .skip(hourInt)
            .take(24)
            .map((forecastHour) {
          final inputDateFormat = DateFormat('yyyy-MM-dd HH:mm');
          final date = inputDateFormat.parse(forecastHour.time ?? '');
          final hourString = DateFormat.H().format(date);
          return [
            (int.parse(hourString) == hourInt) ? 'Now' : hourString,
            'https:${forecastHour.condition.weatherIcon}',
            '${forecastHour.tempC.toInt()}°',
          ];
        }).toList();

    final tenDaysForecastTitle = '10-DAY FORECAST';

    List<List<String>> tenDaysForecastData =
        forecastResponse!.forecast.forecastday.map((forecastDay) {
          final dateTime = forecastDay.date;
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final dateToParse = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
          );
          final dateString =
              (dateToParse == today)
                  ? 'Today'
                  : DateFormat(DateFormat.ABBR_WEEKDAY).format(dateTime);

          final iconUrlString =
              'https:${forecastDay.day.condition.weatherIcon}';

          final minTemp = '${forecastDay.day.mintempC.toInt()}°';
          final maxTemp = '${forecastDay.day.maxtempC.toInt()}°';

          return [dateString, iconUrlString, minTemp, maxTemp];
        }).toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    isDay
                        ? AssetImage('assets/bg_partly_cloud.jpg')
                        : AssetImage('assets/bg_night.jpg'),
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
                  nextHoursForecastData: nextHoursForecastData,
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
