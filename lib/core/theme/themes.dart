import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF59A5D8),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF4F9FF),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF59A5D8),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white, elevation: 8),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleLarge: GoogleFonts.oswald(
      fontSize: 30,
      fontStyle: FontStyle.italic,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.merriweather(color: Colors.black87),
    displaySmall: GoogleFonts.pacifico(color: Colors.black87),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF386FA4)),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF23B5D3),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xFF2F4550),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF23B5D3),
    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
    elevation: 0,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: const Color(0xFF2F4550),
    elevation: 8,
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
  iconTheme: const IconThemeData(color: Color(0xFF70B77E)),
);
