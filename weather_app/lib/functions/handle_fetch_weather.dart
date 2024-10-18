import 'package:flutter/material.dart';
import 'package:weather_app/api/fetch_weather_api.dart';

Future<void> handleFetchWeather({
  required String cityName,
  required Function setLoading,
  required Function setData,
  required Function onError,
  required  BuildContext context,
}) async {
  setLoading(true, true); // set loading to true and showCard to true
  final data = await fetchWeathter(cityName,context);
  if (data != null) {
    setData(
      data['weather'][0]['main'],
      data['weather'][0]['description'],
      data['main']['temp'],
      data['name'],
    );
  } else {
    onError();
  }

  setLoading(false, true); // stop shimmer effect and card if need
}
