import '../models/forecast_response.dart';
import '../services/weather_repo.dart';

class HomePageVM {
  ForecastResponse? forecastResponse;

  final weatherRepo = WeatherRepo();
  var isLoaded = false;

  Future<void> getWeatherForecast() async {
    isLoaded = false;
    forecastResponse = await weatherRepo.getWeatherForecast();
    if (forecastResponse != null) {
      isLoaded = true;
    }
  }
}