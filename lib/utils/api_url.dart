import '../api/api_key.dart';

String apiURL(var lat, var long){
  String url = "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=$apiKey&exclude=minutely&units=metric";
  return url;
}