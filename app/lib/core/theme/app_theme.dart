import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.blue,
  hintColor: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.normal, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
    labelLarge: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    labelMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    labelSmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    labelStyle: const TextStyle(color: Colors.blue),
    hintStyle: const TextStyle(color: Colors.blueGrey),
  ),
);

LinearGradient containerGradient = LinearGradient(
  colors: [Colors.blue, Colors.blue.withOpacity(0.5)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
