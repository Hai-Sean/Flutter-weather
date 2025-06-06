import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/forecast_response.dart';
import '../models/home_models/home_header_model.dart';
import '../models/home_models/home_next_hours_model.dart';
import '../models/home_models/home_ten_days_model.dart';
import '../services/weather_repo.dart';

class HomePageVM extends ChangeNotifier {
  ForecastResponse? forecastResponse;
  final weatherRepo = WeatherRepo();
  var isLoaded = false;

  Future<void> getWeatherForecast() async {
    isLoaded = false;
    forecastResponse = await weatherRepo.getWeatherForecast();
    if (forecastResponse != null) {
      isLoaded = true;
      notifyListeners();
    } else {
      // TODO: - handle error
    }
  }

  Future<List<String>> getAutoComplete(String key) async {
    final cityList = await weatherRepo.getAutoCompleteList(key);
    notifyListeners();
    return cityList;
  }

  bool isDay() {
    return forecastResponse?.current.isDay != 0;
  }

  HomeHeaderModel getHeaderModel() {
    var currentLocationName = forecastResponse?.location.name ?? '';
    var currentTemp =
    forecastResponse?.current.tempC == null
        ? '--'
        : '${(forecastResponse?.current.tempC)?.toInt()}°';
    var currentWeatherType =
        forecastResponse?.current.condition.weatherText ?? '';
    var todayMaxTemp =
    forecastResponse?.forecast.forecastday.first.day.maxtempC.toInt();
    var todayMinTemp =
    forecastResponse?.forecast.forecastday.first.day.mintempC.toInt();
    var currentHighLowTemp =
        'H:${'$todayMaxTemp°'}   L:${'$todayMinTemp°'}';

    return HomeHeaderModel(
        currentLocationName: currentLocationName,
        currentTemp: currentTemp,
        currentWeatherType: currentWeatherType,
        currentHighLowTemp: currentHighLowTemp);
  }

  HomeNextHoursModel getNextHoursModel() {
    // TODO: - Remove mock forecast desc
    final nextHoursForecastDesc =
        'Cloudy conditions from 1AM-9AM, with showers expected at 9AM.';

    // 24 + 24 hour, today + tmr
    final twoDayHoursForecastResponse =
        (forecastResponse?.forecast.forecastday.first.hour ?? []) +
            (forecastResponse?.forecast.forecastday[1].hour ?? []);

    // hour now
    final inputDateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final dateNow = inputDateFormat.parse(forecastResponse?.current.lastUpdated ?? '');
    final hourInt = int.parse(DateFormat.H().format(dateNow));

    List<HomeNextHoursDataModel> nextHoursForecastData =
    twoDayHoursForecastResponse.skip(hourInt).take(24).map((forecastHour) {
      final date = inputDateFormat.parse(forecastHour.time ?? '');
      final hourString = DateFormat.H().format(date);
      return HomeNextHoursDataModel(
        time: (int.parse(hourString) == hourInt) ? 'Now' : hourString,
        iconUrlString: 'https:${forecastHour.condition.weatherIcon}',
        temp: '${forecastHour.tempC.toInt()}°',
      );
    }).toList();

    return HomeNextHoursModel(
      nextHoursForecastDesc: nextHoursForecastDesc,
      nextHoursForecastData: nextHoursForecastData,
    );
  }

  HomeTenDaysModel getTenDaysModel() {
    final tenDaysForecastTitle = '10-DAY FORECAST';
    final inputDateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final dateNow = inputDateFormat.parse(forecastResponse?.current.lastUpdated ?? '');
    final today = DateTime(dateNow.year, dateNow.month, dateNow.day);

    List<HomeTenDaysDataModel> tenDaysForecastData =
    (forecastResponse?.forecast.forecastday ?? []).map((forecastDay) {
      final dateTime = forecastDay.date;
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

      return HomeTenDaysDataModel(
        dateString: dateString,
        iconUrlString: iconUrlString,
        minTemp: forecastDay.day.mintempC.toInt(),
        maxTemp: forecastDay.day.maxtempC.toInt(),
      );
    }).toList();

    return HomeTenDaysModel(
      tenDaysForecastTitle: tenDaysForecastTitle,
      tenDaysForecastData: tenDaysForecastData,
    );
  }
}