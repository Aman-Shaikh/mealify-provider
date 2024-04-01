import 'package:mealify_provider/constants/colors.dart';
import 'package:mealify_provider/features/provider/controllers/provider_chat_controller.dart';
import 'package:mealify_provider/features/provider/screens/provider_home/provider_appbar_widget.dart';
import 'package:mealify_provider/features/provider/screens/provider_messages/provider_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class WChatScreen extends StatelessWidget {
  const WChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: WAppBarWidget("${controller.friendName}"),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                          ),
                        )
                      : Expanded(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Chats")
                                  .doc(controller.chatDocId.toString())
                                  .collection("Messages")
                                  .orderBy('created_on', descending: false)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: SizedBox(
                                          width: 35.0,
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.red))));
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                    child: Text("send a message",
                                        style: TextStyle(color: darkGrey)),
                                  );
                                } else {
                                  return ListView(
                                    children: snapshot.data!.docs
                                        .mapIndexed((currentValue, index) {
                                      var data = snapshot.data!.docs[index];
                                      return Align(
                                          alignment: data['uid'] ==
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: WChatBubble(data));
                                    }).toList(),
                                  );
                                }
                              })),
                ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.msgController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        hintText: "Type a message...",
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          controller.sendMsg(controller.msgController.text);
                          controller.msgController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.red,
                        )),
                  ],
                )
                    .box
                    .height(80)
                    .padding(EdgeInsets.all(12))
                    .margin(EdgeInsets.only(bottom: 8))
                    .make()
              ],
            )));
  }
}

// class WChatScreen extends StatelessWidget {
//   const WChatScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: WAppBarWidget("Provider Chat"),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                   itemCount: 20,
//                   itemBuilder: (BuildContext context, int index) {
//                     return WChatBubble();
//                   }),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               height: 60,
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: TextFormField(
//                     decoration: const InputDecoration(
//                       isDense: true,
//                       hintText: "Enter message",
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: purpleColor)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: purpleColor)),
//                     ),
//                   )),
//                   IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.send, color: purpleColor))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
