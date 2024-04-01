import 'package:mealify_provider/constants/colors.dart';
import 'package:flutter/material.dart';

class WHSButtonWidget extends StatelessWidget {
  const WHSButtonWidget({
    Key? key,
    required this.title,
    required this.count,
    required this.logo,
  }) : super(key: key);

  final String title;
  final String count;
  final String logo;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    return Container(
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: screenWidth * 0.4,
      height: screenHeight * 0.1,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: myWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  count,
                  style: const TextStyle(
                      color: myWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Image.asset(logo, width: 50),
        ],
      ),
    );
  }
}
