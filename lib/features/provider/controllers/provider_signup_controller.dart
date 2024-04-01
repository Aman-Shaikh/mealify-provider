
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/provider_authentication_repository.dart';
import '../../../repository/user_repository/provider_repository.dart';
import '../models/provider_model.dart';

class WSignUpController extends GetxController {
  static WSignUpController get instance => Get.find();

  var isLoading = false.obs;

//TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

//Call this Function from Design & it will do the rest
//   Future<void> registerProvider(String email, String password) async{
//     String? error =await AuthenticationRepository.instance.createProviderWithEmailAndPassword(email, password);
//     if (error != null)
//       {
//         Get.snackbar("Error :",error.toString(),
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.redAccent.withOpacity(0.1),
//             colorText: Colors.red);
//       }
//     else
//       {
//
//       }
//   }

  //Call this Function from Design & it will do the rest

  Future<void> registerProvider(ProviderModel provider) async {
    isLoading.value = true;
    String? error = await WAuthenticationRepository.instance
        .createProviderWithEmailAndPassword(
            provider.email, provider.password);
    if (error != null) {
      Get.snackbar("Error :", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      isLoading.value = false;
    } else {
      createProvider(provider);
    }
  }

  // Get phoneNo from provider and pass it to Auth Repository for firebase Authentication
  void phoneAuthentication(String phoneNo) {
    WAuthenticationRepository.instance.wPhoneAuthentication(phoneNo);
  }

  //creating provider storing providers data in database
  final providerRepo = Get.put(ProviderRepository());

  Future<void> createProvider(ProviderModel provider) async {
    await providerRepo.createProvider(provider);
    isLoading.value = false;
    // do work after creation of provider

    // for email and password authentication
    // registerProvider(provider.email,provider.password);

    // for phone authentication
    // phoneAuthentication(provider.phoneNo);
    // Get.to(() => const OTPScreen());
  }

  Future<void> registerProviderWithGoogle() async {
    String? error =
        await WAuthenticationRepository.instance.wSignInWithGoogle();
    if (error != null) {
      Get.snackbar("Error :", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    } else {
      final provider = ProviderModel(
          email: FirebaseAuth.instance.currentUser!.email!,
          password: "Amanshaikh123#\$",
          fullName: FirebaseAuth.instance.currentUser!.displayName!);
      createProvider(provider);
    }
  }
}
