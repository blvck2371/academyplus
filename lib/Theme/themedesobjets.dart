import 'package:flutter/material.dart';

// Thème clair
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryColorDark: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
  ),
);

// Thème sombre
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColorDark: Colors.white,
  primaryColor: const Color.fromARGB(255, 22, 22, 22), // Noir ardoise
  scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
