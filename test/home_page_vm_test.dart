import 'package:test/test.dart';
import 'package:weather_app/home/home_page.dart';
import 'package:weather_app/home/home_page_vm.dart';

void main() {
  group('HomePage', () {
    test('Response should not be null', () async {
      final vm = HomePageVM();
      await vm.getWeatherForecast();
      expect(vm.isLoaded, true);
      expectLater(vm.forecastResponse != null, true);
    });
  });
}