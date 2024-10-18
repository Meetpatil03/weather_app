import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/contants.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.system;
  late ThemeData _darkScheme = darkColorSchema;
  late ThemeData _lightScheme = lightColorSchema;

  ThemeProvider() {
    // Load theme mode from shared preferences when the provider is initialized
    _loadThemeMode();
  }


  ThemeMode get themeMode => _themeMode;

  // Function to set a specific theme mode
  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    _saveThemeMode(value); // Save the theme mode in shared preferences
    notifyListeners();
  }

  // Function to toggle between light and dark mode manually
  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }

  ThemeData get darkScheme => _darkScheme;
  void setDarkScheme(ThemeData value) {
    _darkScheme = value;
    notifyListeners();
  }

  ThemeData get lightScheme => _lightScheme;
  void setLightScheme(ThemeData value) {
    _lightScheme = value;

    notifyListeners();
  }

  // Load the theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('themeMode');
    if (theme != null) {
      if (theme == 'light') {
        _themeMode = ThemeMode.light;
      } else if (theme == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
    }
    notifyListeners();
  }

  // Save the theme mode to SharedPreferences
  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light) {
      prefs.setString('themeMode', 'light');
    } else if (themeMode == ThemeMode.dark) {
      prefs.setString('themeMode', 'dark');
    } else {
      prefs.setString('themeMode', 'system');
    }
  }
}