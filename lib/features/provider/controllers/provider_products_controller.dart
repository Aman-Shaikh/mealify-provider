import 'dart:io';

import 'package:mealify_provider/features/provider/controllers/home_controller.dart';
import 'package:mealify_provider/features/provider/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductsController extends GetxController {
  var isLoading = false.obs;

  static ProductsController get instance => Get.find();

  var pNameController = TextEditingController();
  var pDescController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColors = [];
  var commonClothsColors = [
    Colors.red.value,
    Colors.blue.value,
    Colors.green.value,
    Colors.yellow.value,
    Colors.orange.value,
    Colors.purple.value,
    Colors.black.value,
    Colors.pink.value,
    Colors.brown.value,
    Colors.grey.value,
  ];

  getCategories() async {
    var data = await rootBundle
        .loadString("lib/features/provider/models/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();

    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategoryList(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategories.length; i++) {
      subcategoryList.add(data.first.subcategories[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null)
        return;
      else {
        pImagesList[index] = File(img.path);
        print("Image added");
      }
    } catch (e) {
      Get.snackbar("Error :", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  uploadImages() async {
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination =
            'images/consumers/${FirebaseAuth.instance.currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);

        var n = await ref.getDownloadURL();

        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = FirebaseFirestore.instance.collection("Meals").doc();
    await store
        .set({
          'is_featured': false,
          'p_category': categoryvalue.value,
          'p_subcategory': subcategoryvalue.value,
          'p_colors': FieldValue.arrayUnion(selectedColors),
          'p_imgs': FieldValue.arrayUnion(pImagesLinks),
          'p_wishlist': FieldValue.arrayUnion([]),
          'p_desc': pDescController.text,
          'p_name': pNameController.text,
          'p_price': pPriceController.text,
          'p_quantity': int.parse(pQuantityController.text),
          'p_name': pNameController.text,
          'p_seller': Get.find<HomeController>().username,
          'p_rating': "5.0",
          'vendor_id': FirebaseAuth.instance.currentUser!.uid,
          'featured_id': '',
        })
        .whenComplete(
          () => Get.snackbar(
              "Success", "Your Product has been added successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
          Get.snackbar("Error",
              "Something went wrong product can not be added please check the provider_products_controller file.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
          print("====>" + error.toString());
        });
    isLoading.value = false;
  }

  addFeatured(docId) async {
    await FirebaseFirestore.instance
        .collection("Meals")
        .doc(docId)
        .set({
          'featured_id': FirebaseAuth.instance.currentUser!.uid,
          'is_featured': true,
        }, SetOptions(merge: true))
        .whenComplete(
          () => Get.snackbar("Success", "Featured Successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
          Get.snackbar("Error",
              "Something went wrong please check the add feature function in provider_products_controller file.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
          print(error.toString());
        });
  }

  removeFeatured(docId) async {
    await FirebaseFirestore.instance
        .collection("Meals")
        .doc(docId)
        .set({
          'featured_id': '',
          'is_featured': false,
        }, SetOptions(merge: true))
        .whenComplete(
          () => Get.snackbar("Success", "Featured Removed Successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
          Get.snackbar("Error",
              "Something went wrong please check the remove feature function in provider_products_controller file.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
          print(error.toString());
        });
  }

  removeProduct(docId) async {
    await removeImages(docId);

    await FirebaseFirestore.instance
        .collection("Meals")
        .doc(docId)
        .delete()
        .whenComplete(
          () => Get.snackbar("Success", "Product Removed Successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error",
          "Something went wrong please check the removeProduct function in provider_products_controller file.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<void> removeImages(docId) async {
    DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection("Meals")
        .doc(docId)
        .get();
    final data = ref.data() as Map<String, dynamic>;
    int len = data['p_imgs'].length;
    for (int i = 0; i < len; i++) {
      Reference imgref = await FirebaseStorage.instance.refFromURL(data['p_imgs'][i]);

      // Delete the image from Firebase Storage
      // await imgref.delete().then((value) {
      //   print("Image deleted successfully.");
      // }).catchError((error) {
      //   print("Failed to delete image: $error");
      //   Get.snackbar("Error",
      //       "Not able to delete images please check the removeProduct function in provider_products_controller file.",
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.redAccent.withOpacity(0.1),
      //       colorText: Colors.red);
      // });

      await imgref.delete();
    }
  }

  editProduct(docId) async{
    var store = FirebaseFirestore.instance.collection("Meals").doc(docId);
    await store
        .update({
      'is_featured': false,
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_colors': FieldValue.arrayUnion(selectedColors),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pDescController.text,
      'p_name': pNameController.text,
      'p_price': pPriceController.text,
      'p_quantity': int.parse(pQuantityController.text),
      'p_name': pNameController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': FirebaseAuth.instance.currentUser!.uid,
      'featured_id': '',
    })
        .whenComplete(
          () => Get.snackbar(
          "Success", "Your Product has been edited successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error",
          "Something went wrong product can not be added please check the provider_products_controller file.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("====>" + error.toString());
    });
    isLoading.value = false;
  }
}
