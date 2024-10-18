import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherList extends ChangeNotifier {
  List<WeatherModel> _list = [];

  List<WeatherModel> get weatherList => _list;

 void getWeather(String cityName, String weatherMain,
    String weatherDescription, double temperature) {
  
  // Check if the city already exists in the list
  final existingCityIndex =
      _list.indexWhere((weather) => weather.cityName.toLowerCase() == cityName.toLowerCase());

  if (existingCityIndex == -1) {
    // City doesn't exist, so add a new entry
    _list.add(WeatherModel(
        cityName: cityName,
        weatherMain: weatherMain,
        weatherDescription: weatherDescription,
        temperature: temperature));
  } else {
    // City already exists, you could update it or ignore it
    print("City already exists in the list");
  }

  print(_list.length);
  notifyListeners();
}
  void deletAllWeatherList() {
    _list.clear();
    notifyListeners();
  }
}
