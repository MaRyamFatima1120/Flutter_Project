import 'package:flutter/material.dart';
import 'package:todo_app_with_sharedpreference/src/themes/color_scheme.dart';
import 'package:todo_app_with_sharedpreference/src/themes/text_theme.dart';

ThemeData appTheme(BuildContext context,) {
  return ThemeData(
    colorScheme: darkColorScheme,
    textTheme: customTextTheme(context),
    primaryColor:  darkColorScheme.primary ,
    scaffoldBackgroundColor:  darkColorScheme.surface,
  );
}
