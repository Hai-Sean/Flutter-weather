import 'package:test/test.dart';
import 'package:weather_app/home/home_page.dart';
import 'package:weather_app/home/home_page_vm.dart';

void main() {
  group('HomePage', () {
    test('Forecast response should not be null', () async {
      final vm = HomePageVM();
      await vm.getWeatherForecast();
      expect(vm.isLoaded, true);
      expectLater(vm.forecastResponse != null, true);
    });

    test('Autocomplete response should not be null', () async {
      final vm = HomePageVM();
      final result = await vm.getAutoComplete('Hanoi');
      expectLater(result != null, true);
    });
  });
}