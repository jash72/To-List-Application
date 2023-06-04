import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color pinkishClr = Color(0xFFEF9A9A);
const Color yellow = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = pinkishClr;
const Color darkGeryClr = Color(0xFF121212);
Color darkHeaderClr = const Color(0xFF424242);
class Themes{
  static final light = ThemeData(
      primaryColor: primaryClr,
      brightness: Brightness.light
  );

  static final dark =  ThemeData(
      primaryColor: darkGeryClr,
      brightness: Brightness.light
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 20
        )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold
      )
  );
}