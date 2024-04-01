import 'package:mealify_provider/constants/colors.dart';
import 'package:flutter/material.dart';

Widget WOrderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title1",
              style: TextStyle(fontWeight: FontWeight.bold, color: purpleColor),
            ),
            Text(
              "$d1",
              style: TextStyle(fontWeight: FontWeight.bold, color: red),
            ),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title2",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: purpleColor),
              ),
              Text(
                "$d2",
                style: TextStyle(fontWeight: FontWeight.bold, color: red),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
