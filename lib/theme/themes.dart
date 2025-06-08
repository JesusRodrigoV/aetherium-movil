import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.lightGreenAccent.shade700,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.orange.shade700,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.oswald(
      fontSize: 30,
      fontStyle: FontStyle.italic,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.merriweather(color: Colors.black),
    displaySmall: GoogleFonts.pacifico(color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple.shade700,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.oswald(
      fontSize: 30,
      fontStyle: FontStyle.italic,
      color: Colors.white70,
    ),
    bodyMedium: GoogleFonts.merriweather(color: Colors.white),
    displaySmall: GoogleFonts.pacifico(color: Colors.white),
  ),
);
