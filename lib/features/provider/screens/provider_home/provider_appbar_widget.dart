import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

AppBar WAppBarWidget(title) {
  return AppBar(
    leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
        )),
    title: Text(title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
    // actions: [
    //   Center(
    //       child: Text(
    //           intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
    //           style:
    //               const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
    //   const SizedBox(width: 10),
    // ],
  );
}
