import 'dart:convert';
import 'package:agrimatics/model/weather/weather_data.dart';
import 'package:agrimatics/model/weather/weather_data_current.dart';
import 'package:agrimatics/model/weather/weather_data_daily.dart';
import 'package:agrimatics/model/weather/weather_data_hourly.dart';
import 'package:http/http.dart' as http;

import '../utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  //processing the data

  Future<WeatherData> processData(lat, long) async {
    var response = await http.get(Uri.parse(apiURL(lat, long)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString), WeatherDataDaily.fromJson(jsonString));
    return weatherData!;
  }
}
