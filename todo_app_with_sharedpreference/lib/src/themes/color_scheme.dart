import 'package:flutter/material.dart';

//dark theme
const Color primary =Color(0xff8687e7);
const Color onPrimary =Colors.white;
const Color secondary =Color(0xff363636);
const Color onSecondary =Color(0xff838383);
const Color surface = Color(0xff121212);

ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    error: Colors.red,
    onError: Colors.white,
    surface: surface,
    onSurface: Colors.white,

);

// Light Theme Colors
const Color primaryLight = Color(0xff8687e7);
const Color onPrimaryLight = Colors.white;
const Color secondaryLight = Color(0xff03dac6);
const Color onSecondaryLight = Colors.black;
const Color surfaceLight = Colors.white;

ColorScheme lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: primaryLight,
  onPrimary: onPrimaryLight,
  secondary: secondaryLight,
  onSecondary: onSecondaryLight,
  error: Colors.red,
  onError: Colors.black,
  surface: surfaceLight,
  onSurface: Colors.black,
);