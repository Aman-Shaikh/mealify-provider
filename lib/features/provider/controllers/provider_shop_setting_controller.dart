import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopSettingController extends GetxController {
  static ShopSettingController get instance => Get.find();

  // shop setting controllers
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescriptionController = TextEditingController();

  var isLoading = false.obs;

  updateShop(
      {shopName, shopAddress, shopMobile, shopWebsite, shopDescription}) async {
    isLoading.value = true;
    var store = FirebaseFirestore.instance
        .collection("Providers")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await store
        .set(
          {
            "shop_name": shopName,
            "shop_address": shopAddress,
            "shop_mobile": shopMobile,
            "shop_website": shopWebsite,
            "shop_description": shopDescription,
          },
          SetOptions(merge: true),
        )
        .whenComplete(
          () => Get.snackbar(
              "Success", "Your Shop data has been Edited successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
          Get.snackbar("Error",
              "Something went wrong please check shop setting controller file.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
          print(error.toString());
        });
    isLoading.value = false;
  }
}
