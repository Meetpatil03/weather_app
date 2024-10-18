import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/provider/provider_service.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherList>(create: (_) => WeatherList()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Weather App',
          theme: themeProvider.lightScheme,
          
          darkTheme: themeProvider.darkScheme,
          themeMode: themeProvider.themeMode,
          home: const WeatherScreen(),
        );
      }),
    );
  }
}
