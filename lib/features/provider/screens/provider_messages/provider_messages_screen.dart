import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_messages/provider_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class WMessagesScreen extends StatelessWidget {
  const WMessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBarWidget("Provider Messages"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Chats")
            .where('toId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null
                        ? DateTime.now()
                        : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: () {
                        Get.to(() => const WChatScreen(),arguments: [data[index]['sender_name'],data[index]['fromid']],);

                      },
                      leading: const CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: myWhiteColor,
                          )),
                      title: Text("${data[index]['sender_name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: lightGrey)),
                      subtitle: Text("${data[index]['last_msg']}",
                          style: TextStyle(color: darkGrey)),
                      trailing: Text(time, style: TextStyle(color: darkGrey)),
                    );
                  }),
                ),
              ),
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
