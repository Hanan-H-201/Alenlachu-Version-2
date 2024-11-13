import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color pastelBlue = Color(0xFFAEDFF7);
const Color softGreen = Color(0xFFC5E3D4);
const Color lightLavender = Color(0xFFE6E6FA);
const Color warmBeige = Color(0xFFF5F5DC);
const Color darkGray = Color(0xFF2C2C2C);
const Color accentTeal = Color(0xFF81D4FA);

final ThemeData appTheme = ThemeData(
  primaryColor: pastelBlue,
  hintColor: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'DM Sans',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: darkGray),
    headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        color: darkGray),
    headlineSmall: TextStyle(
        fontSize: 16.0,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
        color: darkGray),
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
        color: darkGray),
    labelMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: darkGray),
    labelSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        color: darkGray),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: accentTeal,
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
      borderSide: const BorderSide(color: Color(0xFFAEDFF7)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color(0xFFAEDFF7)),
    ),
    labelStyle: const TextStyle(color: Color(0xFFAEDFF7)),
    hintStyle: TextStyle(
        color: const Color(0xFFAEDFF7).withOpacity(0.7)),
  ),
);

LinearGradient containerGradient = LinearGradient(
  colors: [pastelBlue, lightLavender],  // Gradient from pastel blue to light lavender
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
