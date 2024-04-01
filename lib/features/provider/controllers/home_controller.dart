import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  var navIndex = 0.obs;
  var username = '';
  @override
  void onInit()
  {
    super.onInit();
    getUsername();
  }

  getUsername()async{
    var n = await FirebaseFirestore.instance.collection("Providers").where('id',isEqualTo:FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['FullName'];
      }
    });
    username = n.toString();
  }
}
