import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/constants/sizes.dart';
import 'package:mealify_provider/constants/text_strings.dart';
import 'package:mealify_provider/features/entry_point/controllers/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    final screenWidth = MediaQuery.of(context).size.width;
    // Ensure that the image width does not exceed the screen width
    final imageWidth = screenWidth *0.95; // Adjust the image width as needed
    // Calculate the maximum left padding to prevent going offscreen
    final maxLeftPadding = screenWidth - imageWidth;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: 80,
            // Adjust left to ensure it doesn't go offscreen
            left: splashController.animate.value ? (screenWidth / 2 - imageWidth / 2).clamp(-80.0, maxLeftPadding) : -80,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: splashController.animate.value ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myAppName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    myAppTagLine,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          )),
          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 2400),
            bottom: splashController.animate.value ? 100 : 0,
            // Center the image within the screen width
            left: (screenWidth - imageWidth) / 2,
            right: (screenWidth - imageWidth) / 2,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: splashController.animate.value ? 1 : 0,
              // Adjust the image width to fit within the screen bounds
              child: Image(
                width: imageWidth,
                image: AssetImage(foodSearching),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
