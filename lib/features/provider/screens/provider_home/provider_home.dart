import 'package:mealify_provider/constants/image_strings.dart';
import 'package:mealify_provider/features/provider/controllers/home_controller.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_home_screen.dart';
import 'package:mealify_provider/features/provider/screens/provider_orders/provider_orders_screen.dart';
import 'package:mealify_provider/features/provider/screens/provider_products/provider_products_screen.dart';
import 'package:mealify_provider/features/provider/screens/provider_profile/provider_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';

class ProviderHome extends StatelessWidget {
  const ProviderHome({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const ProviderHomeScreen(),
      const ProviderProductsScreen(),
      const ProviderOrdersScreen(),
      const ProviderProfileScreen()
    ];

    var bottomNavbar = [
      BottomNavigationBarItem(
          icon: Image.asset(myHomeLogo, height: 24), label: "dashboard"),
      BottomNavigationBarItem(
          icon: Image.asset(myMeals, height: 24), label: "Meals"),
      BottomNavigationBarItem(
          icon: Image.asset(myOrders, height: 24), label: "orders"),
      BottomNavigationBarItem(
          icon: Image.asset(myAccout, height: 24), label: "Profile"),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ), // BottomlavigationBar
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    ); // Scaffold
  }
}
