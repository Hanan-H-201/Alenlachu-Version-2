import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 13, 55, 90),
  hintColor: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 13, 55, 90)),
    headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        color: Color.fromARGB(255, 13, 55, 90)),
    headlineSmall: TextStyle(
        fontSize: 16.0,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 13, 55, 90)),
    titleLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.normal, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.black),
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(fontSize: 16.0, overflow: TextOverflow.ellipsis,color: Colors.black),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.black),
    labelLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 13, 55, 90)),
    labelMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 13, 55, 90)),
    labelSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        color: Color.fromARGB(255, 13, 55, 90)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color.fromARGB(255, 13, 55, 90),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 13, 55, 90),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color.fromARGB(255, 13, 55, 90)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color.fromARGB(255, 13, 55, 90)),
    ),
    labelStyle: const TextStyle(color: Color.fromARGB(255, 13, 55, 90)),
    hintStyle: TextStyle(
        color: const Color.fromARGB(255, 13, 55, 90).withOpacity(0.7)),
  ),
);

LinearGradient containerGradient = LinearGradient(
  colors: [
    const Color.fromARGB(255, 13, 55, 90),
    const Color.fromARGB(255, 13, 55, 90).withOpacity(0.7),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
