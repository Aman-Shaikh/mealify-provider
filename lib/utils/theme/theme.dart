import 'package:mealify_provider/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:mealify_provider/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:mealify_provider/utils/theme/widget_themes/text_field_theme.dart';
import 'package:mealify_provider/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: MyTextTheme.lightTextTheme,
      outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: MyTextTheme.darkTextTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme,
  );
}