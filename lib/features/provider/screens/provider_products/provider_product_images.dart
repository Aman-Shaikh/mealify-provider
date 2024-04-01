import 'package:mealify_provider/constants/colors.dart';
import 'package:flutter/material.dart';

Widget WProductImages({required label, onPress}) {
  return Container(
      decoration: BoxDecoration(
          color: textfieldGrey, borderRadius: BorderRadius.circular(12.0)),
      width: 100,
      height: 100,
      child: Center(
          child: Text(
        "$label",
        style: TextStyle(color: lightGrey, fontSize: 16.0),
      )));
}
