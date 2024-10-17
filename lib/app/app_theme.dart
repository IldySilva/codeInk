import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noThumb),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark),
  );
}
