import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home/home_page_vm.dart';

import '../conditions/conditions_page.dart';
import 'components/current_temp_header.dart';
import 'components/next_hours_forecast.dart';
import 'components/ten_days_forecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  var searchModeOn = false;

  @override
  void initState() {
    super.initState();

    // fetch remote data
    Provider.of<HomePageVM>(context, listen: false).getWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomePageVM>(context);

    Future<void> getWeatherForecast() async {
      await vm.getWeatherForecast();
      if (vm.forecastResponse != null) {
        setState(() {
          searchModeOn = false;
          print('Loaded');
        });
      }
    }

    void presentConditionsScreen() {
      Navigator.of(context).push(
        CupertinoPageRoute(
          fullscreenDialog: false,
          builder: (context) => ConditionsPage(response: vm.forecastResponse),
        ),
      );
    }

    void showSearchView() {
      setState(() {
        searchModeOn = true;
      });
    }

    void searchTrigger(String value) {
      vm.weatherRepo.updateCurrentLocation(value);
      getWeatherForecast();
    }

    Widget loadingView = Center(
      child: CircularProgressIndicator(color: Colors.white),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    vm.isDay()
                        ? AssetImage('assets/bg_partly_cloud.jpg')
                        : AssetImage('assets/bg_night.jpg'),
              ),
            ),
          ),
          Center(
            child:
                !vm.isLoaded
                    ? loadingView
                    : RefreshIndicator(
                      onRefresh: getWeatherForecast,
                      backgroundColor: Colors.transparent,
                      child: ListView(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0,
                            ),
                            height: 34,
                            child:
                                !searchModeOn
                                    ? SearchLocationIcon(
                                      showSearchView: showSearchView,
                                    )
                                    : SearchLocationInput(
                                      controller: controller,
                                      searchTrigger: searchTrigger,
                                    ),
                          ),
                          CurrentTempHeaderView(model: vm.getHeaderModel()),
                          SizedBox(height: 44),
                          NextHoursForecast(model: vm.getNextHoursModel()),
                          TenDaysForecast(
                            model: vm.getTenDaysModel(),
                            onSelectItem: presentConditionsScreen,
                          ),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class SearchLocationInput extends StatelessWidget {
  SearchLocationInput({
    super.key,
    required this.controller,
    required this.searchTrigger,
  });

  final TextEditingController controller;
  ValueChanged<String>? searchTrigger;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white.withAlpha(200)),
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.search,
      onSubmitted: searchTrigger,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withAlpha(80), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.all(10.0),
        hintText: "Select a new location",
      ),
    );
  }
}

class SearchLocationIcon extends StatelessWidget {
  SearchLocationIcon({super.key, required this.showSearchView});

  VoidCallback showSearchView;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: showSearchView,
      icon: Icon(Icons.search, color: Colors.white),
    );
  }
}
