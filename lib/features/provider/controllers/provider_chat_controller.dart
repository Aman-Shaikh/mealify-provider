
import 'package:mealify_provider/features/provider/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  @override
  void onInit(){
    getChatId();
    super.onInit();
  }
  var isLoading=false.obs;
  var Chats = FirebaseFirestore.instance.collection("Chats");

  // retailers detail
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  // my (providers) details
  var senderName = Get.find<HomeController>().username;

  var currentId = FirebaseAuth.instance.currentUser!.uid;

  var msgController = TextEditingController();
  dynamic chatDocId;

  getChatId() async {

    isLoading(true);

    await Chats.where('users',isEqualTo: {
      friendId:null,
      currentId:null
    }
    ).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId=snapshot.docs.single.id;
      }
      else{
        Chats.add({
          'created_on':null,
          'last_msg':'',
          'users':{friendId:null,currentId:null},
          'toId':'',
          'fromid':'',
          'friend_name':senderName,
          'sender_name':friendName,
        }).then((value) {
          chatDocId=value.id;
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      Chats.doc(chatDocId).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_msg':msg,
        // 'toId':currentId,
        // 'fromid':friendId,
      });

      Chats.doc(chatDocId).collection("Messages").doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'msg':msg,
        'uid':currentId,
      });
    }
  }




}