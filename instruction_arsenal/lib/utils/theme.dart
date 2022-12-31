import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTheme {
  static TextStyle get title1 => GoogleFonts.getFont(
    'Poppins',
    color: const Color(0xFF303030),
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static ThemeData get lightTheme { //1
    return ThemeData( //2
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3

        buttonTheme: ButtonThemeData( // 4
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.blueAccent,
        ),
        iconTheme: const IconThemeData(
        color: Colors.black
    ),

    );

  }
}
//TODO actually use theme