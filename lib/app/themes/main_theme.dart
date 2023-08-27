import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,brightness: Brightness.dark),
    useMaterial3: true,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))
    ),
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.blueAccent,
        titleTextStyle: GoogleFonts.roboto(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
        elevation: 0,
    ),
    textTheme: TextTheme(
        bodyMedium: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)
    )
);