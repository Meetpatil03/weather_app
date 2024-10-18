import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/contants.dart';
import 'package:weather_app/provider/provider_service.dart';
import 'package:weather_app/widgets/alert_dialog_box.dart';

Future<Map<String, dynamic>?> fetchWeathter(
    String cityName, BuildContext context) async {
  String url =
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

   WeatherList weatherData = Provider.of<WeatherList>(context, listen: false);

  try {
    Dio dio = Dio();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;

      String weatherMain = data['weather'][0]['main'];
      String weatherDescription = data['weather'][0]['description'];
      double temperature = data['main']['temp'];
      String city = data['name'];

      weatherData.getWeather(
          city, weatherMain, weatherDescription, temperature);

      print(response.data);

      return response.data;
    } else {
      print("Failed : ${response.statusCode}");
      String message = response.data['message'];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              message: message,
            );
          });
      print(message);
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
