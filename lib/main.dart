import 'package:mealify_provider/features/entry_point/screens/splash_screen/splash_screen.dart';
import 'package:mealify_provider/firebase_options.dart';
import 'package:mealify_provider/repository/authentication_repository/provider_authentication_repository.dart';
import 'package:mealify_provider/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthenticationRepository()));
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(WAuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mealify Provider',
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // defaultTransition: Transition.leftToRightWithFade,
      // transitionDuration: const Duration(milliseconds: 500),
      home: SplashScreen(),
    );
  }
}

