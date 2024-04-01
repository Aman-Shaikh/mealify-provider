import 'package:mealify_provider/features/provider/models/provider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderRepository extends GetxController {
  static ProviderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // -- Storing data
  createProvider(ProviderModel provider) async {
    await _db
        .collection("Providers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(provider.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error",
          "User Authentication has been successfull but was not added into databse.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // fetch provider details
  Future<ProviderModel> getProviderDetails(String email) async {
    final snapshot = await _db
        .collection("Providers")
        .where("Email", isEqualTo: email)
        .get();

    final providerData =
        snapshot.docs.map((e) => ProviderModel.fromSnapshot(e)).single;
    return providerData;
  }

  // fetch all providers
  Future<List<ProviderModel>> allProviders() async {
    final snapshot = await _db.collection("Providers").get();

    final providerData =
        snapshot.docs.map((e) => ProviderModel.fromSnapshot(e)).toList();
    return providerData;
  }

  Future<void> updateProviderRecord(ProviderModel provider) async {
    await _db
        .collection("Providers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(provider.toJson())
        .whenComplete(
          () {
            Get.snackbar(
                "Success", "Your account has been Edited Successfully.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green);
            print("Profile Updated");

          })
        .catchError((error, stackTrace) {
      Get.snackbar("Error",
          "Something went wrong please check provider repository file.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });

  }
}
