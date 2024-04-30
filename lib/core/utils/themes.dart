import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    canvasColor: canvas,
    focusColor: primary.withOpacity(0.1),
    dividerColor: const Color(0xffBBBBBB),
    hintColor: Colors.black,
    splashColor: background,
    colorScheme: ColorScheme.light(
      background: background,
      primary: primary,
      secondary: canvas,
      shadow: Colors.black,
      error: Colors.red,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      headlineMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w800)),
      headlineSmall: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w900)),

      titleLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700)),
      titleMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w600)),
      titleSmall: GoogleFonts.harmattan(textStyle: const TextStyle(color: Colors.black87)),

      bodyLarge: GoogleFonts.harmattan(textStyle: const TextStyle(color: Colors.black)),
      bodyMedium: GoogleFonts.harmattan(textStyle: const TextStyle(color: Colors.black87)),
      bodySmall: GoogleFonts.harmattan(textStyle: const TextStyle(color: Colors.black87)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      shadowColor: primary,
      backgroundColor: primary,
      textStyle: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white)),
    )),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      shadowColor: Colors.black,
      color: canvas,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      backgroundColor: background,
    ),
    scaffoldBackgroundColor: background,
    disabledColor: const Color(0xff909090),
    shadowColor: Colors.black54,
  );
}
