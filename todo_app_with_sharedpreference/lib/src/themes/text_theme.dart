import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_with_sharedpreference/src/themes/color_scheme.dart';

TextTheme customTextTheme(BuildContext context){

  return TextTheme(
    bodyLarge: GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: darkColorScheme.onPrimary
      )
    ),
      bodySmall: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: darkColorScheme.onPrimary
          )
      )
  );
}