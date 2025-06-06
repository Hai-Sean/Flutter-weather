class HomeTenDaysModel {
  String tenDaysForecastTitle;
  List<HomeTenDaysDataModel> tenDaysForecastData;

  HomeTenDaysModel({
    required this.tenDaysForecastTitle,
    required this.tenDaysForecastData,
});
}

class HomeTenDaysDataModel {
  String dateString;
  String iconUrlString;
  int minTemp;
  int maxTemp;

  HomeTenDaysDataModel({
    required this.dateString,
    required this.iconUrlString,
    required this.minTemp,
    required this.maxTemp,
  });
}