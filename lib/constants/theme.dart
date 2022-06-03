import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(bodyText2:GoogleFonts.baloo2(),),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(bodyText2:GoogleFonts.baloo2(),),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff15161a),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xff15161a),
  ),
);
