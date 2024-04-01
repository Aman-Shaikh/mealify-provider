import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../repository/authentication_repository/provider_authentication_repository.dart';
import '../../../repository/user_repository/provider_repository.dart';
import '../models/provider_model.dart';


class WProfileController extends GetxController {
  static WProfileController get instance => Get.find();

  //Repositories
  final _authRepo = Get.put(WAuthenticationRepository());
  final _ProviderRepo = Get.put(ProviderRepository());
  var isLoading = false.obs;
  var wImage=null;
  var imageChanged=false.obs;
  var imageLink=null;

  // Get Provider email and pass to ProviderRepository to fetch Provider record.
  getProviderData() {
    final email = _authRepo.firebaseUser.value?.email;

    if (email != null) {
      return _ProviderRepo.getProviderDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  //fetch list of Provider records
  Future<List<ProviderModel>> getAllProviders() async => await _ProviderRepo.allProviders();

  updateRecord(ProviderModel Provider) async {

    await _ProviderRepo.updateProviderRecord(Provider);

  }

  pickProviderImage() async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
       imageChanged.value = false;
        return;
      }
      else {
        imageChanged.value = false;
        wImage = File(img.path);
        imageChanged.value = true;
      }
    } catch (e) {
      imageChanged.value = false;
      Get.snackbar("Error :",e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  uploadProviderImage() async{
      if(wImage!=null){

        var filename = basename(wImage.path);
        var destination = 'images/consumers/${FirebaseAuth.instance.currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(wImage);
        imageLink = await ref.getDownloadURL();

      }
  }



}
