import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_orders/provider_order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ProviderOrdersScreen extends StatelessWidget {
  const ProviderOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBarWidget("Provider Orders"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Orders")
            .where('vendors',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            print("lenght${data.length}");

            return Column(
              children:[ Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {

                      var time = data[index]['order_date'].toDate();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => WOrderDetails(data: data[index]));
                            },
                            tileColor: textfieldGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: Text("${data[index]['order_code']}",
                                style: const TextStyle(color: purpleColor)),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: lightGrey,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                        intl.DateFormat('d/M/y')
                                            .format(time),
                                        style: const TextStyle(
                                            color: lightGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.payment, color: lightGrey),
                                    SizedBox(width: 10),
                                    Text("Unpaid",
                                        style: const TextStyle(
                                            color: red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Text("${data[index]['total_amount']}",
                                style: const TextStyle(
                                    color: lightGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ),
                        ),
                      );
                    }),
              )],
            );
          } else {
            return Center(
                child: SizedBox(
                    width: 35.0,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red))));
          }
        },
      ),
    );
  }
}
