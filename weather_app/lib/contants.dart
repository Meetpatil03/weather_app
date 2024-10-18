import 'package:flutter/material.dart';

String apiKey = "6e0f04eafb9ab5428db779e126e536d8";

final lightColorSchema = ThemeData.light().copyWith(
  textTheme: const TextTheme(
     bodySmall: TextStyle(color: Colors.black) // Main body text
  )
);
final darkColorSchema = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color.fromRGBO(13, 16, 34, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor:  Color.fromRGBO(13, 16, 34, 1),
  )
);
