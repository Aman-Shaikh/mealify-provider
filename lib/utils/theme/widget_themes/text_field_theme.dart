import 'package:mealify_provider/constants/colors.dart';
import 'package:flutter/material.dart';

class MyTextFormFieldTheme {

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: mySecondaryColor,
    floatingLabelStyle: TextStyle(color: mySecondaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: mySecondaryColor),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: myPrimaryColor,
    floatingLabelStyle: TextStyle(color: myPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: myPrimaryColor),
    ),
  );
}
