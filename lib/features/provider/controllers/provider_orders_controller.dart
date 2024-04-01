import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  static OrdersController get instance => Get.find();

  var orders = [];
  var totalOrders;

  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == FirebaseAuth.instance.currentUser!.uid) {
        orders.add(item);
      }
    }
    totalOrders = orders.length;
  }

  void changeStatus({title, status, docId}) async {
    var store = FirebaseFirestore.instance.collection("Orders").doc(docId);

    await store.set({title: status}, SetOptions(merge: true));
  }
}
