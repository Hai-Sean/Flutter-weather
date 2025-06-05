import 'package:weather_app/models/forecast_response.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/api_key_storage.dart';

import '../models/autocomplete_reponse.dart';

class WeatherRepo {
  final client = http.Client();
  final apiKey = ApiKeyStorage().apiKey;
  final numbDays = '10';
  var location = 'Hanoi';

  void updateCurrentLocation(String newLocation) {
    location = newLocation;
  }

  Future<ForecastResponse?>? getWeatherForecast() async {
    final urlString = 'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$location&days=$numbDays&aqi=no&alerts=no';
    var uri = Uri.parse(urlString);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return forecastResponseFromJson(json);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<String>> getAutoCompleteList(String key) async {
    final urlString = 'http://api.weatherapi.com/v1/search.json?key=$apiKey&q=$key';
    var uri = Uri.parse(urlString);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return autoCompleteResponseFromJson(json).map<String>((model) {
        return model.name;
      }).toList();
    } else {
      return [];
    }
  }
}