class HomeNextHoursModel {
  String nextHoursForecastDesc;
  List<HomeNextHoursDataModel> nextHoursForecastData;

  HomeNextHoursModel({
    required this.nextHoursForecastDesc,
    required this.nextHoursForecastData,
  });
}

class HomeNextHoursDataModel {
  String time;
  String iconUrlString;
  String temp;

  HomeNextHoursDataModel({
    required this.time,
    required this.iconUrlString,
    required this.temp,
  });
}
