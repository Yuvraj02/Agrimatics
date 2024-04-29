import 'package:agrimatics/controller/global_controller.dart';
import 'package:agrimatics/utils/custom_colors.dart';
import 'package:agrimatics/widgets/weather/comfort_level.dart';

import 'package:agrimatics/widgets/weather/hourly_weather_widget.dart';
import 'package:agrimatics/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/weather/current_weather_widget.dart';
import '../widgets/weather/daily_weather_widget.dart';
import '../widgets/weather/header_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  //call getx first
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF2caa5e),
        title: Text(
          "Agrimatics",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      HeaderWidget(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      CurrentWeatherWidget(weatherDataCurrent: globalController.getWeatherData().getCurrentWeather()),
                      SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(weatherDataHourly: globalController.getWeatherData().getHourlyWeather()),
                      SizedBox(
                        height: 20,
                      ),
                      DailyWeatherWidget(weatherDataDaily: globalController.getWeatherData().getDailyWeather(),),
                      Container(height: 1,color: CustomColors.dividerLine,),
                      const SizedBox(height: 10,),
                      ComfortLevel(weatherDataCurrent: globalController.getWeatherData().getCurrentWeather())
                    ],
                  ),
              ),
        ),
      ),
    );
  }
}
