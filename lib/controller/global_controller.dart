import 'package:agrimatics/api/fetch_weather.dart';
import 'package:agrimatics/model/weather/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  //Create various variables

  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  //Create functions for variables to be called
  RxBool checkLoading() => _isLoading;

  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  
  final weatherData = WeatherData().obs;

  WeatherData getWeatherData(){
    print(weatherData.value);
    return weatherData.value;
  }
  @override
  void onInit() {
    // TODO: implement onInit

    if (_isLoading.isTrue) {
      getLocation();
    }else{
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //Return if service not enbaled
    if (!isServiceEnabled) {
      return Future.error("Location not Enabled");
    }

    //Check Status of Permission
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are Denied Forever");
    } else if (locationPermission == LocationPermission.denied) {
      //Request new permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission is Denied");
      }
    }

    //Get current Location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //Update lattitude and longitude
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      //Calling our weather api
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
            weatherData.value = value;
        _isLoading.value = false;
      });

    });
  }

  RxInt getIndex(){
    return _currentIndex;
  }

}
