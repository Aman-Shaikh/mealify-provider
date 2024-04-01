import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

Widget WChatBubble(dynamic data) {
  var t=data['created_on'] ==null?DateTime.now():data['created_on'].toDate();
  var time=intl.DateFormat('h:mma').format(t);
  return Directionality(
    textDirection: data['uid']==FirebaseAuth.instance.currentUser!.uid?TextDirection.rtl:TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: data['uid']==FirebaseAuth.instance.currentUser!.uid?Colors.white:Colors.lightGreenAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // "${data['msg']}".text.white.size(16).make(),
          Text("${data['msg']}",style: TextStyle(color: Colors.black,fontSize: 16,),),
          SizedBox(height: 10),
          // time.text.color(myWhiteColor.withOpacity(0.5)).make()
          Text(time),
        ],
      ),
    ),
  );
}




// Widget WChatBubble(dynamic data) {
//   return Directionality(
//     textDirection: TextDirection.ltr,
//     // textDirection: data ['uid'] == currentUser!.uid
//     //     ? TextDirection.rtl
//     //     : TextDirection.ltr,
//     child: Container(
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//           // color: datal ['uid'] == currentUser!.uid ? red : darkGrey,
//           color: Colors.lightGreenAccent,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//             bottomLeft: Radius.circular(20),
//           )), // BorderRadius.only // BoxDecoration
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // "${data['msg']}".text.white.size(16).make(),
//           Text("Retailer's message goes here..."),
//           SizedBox(height: 10),
//           // time.text.color(myWhiteColor.withOpacity(0.5)).make()
//           Text("3.23PM"),
//         ],
//       ), // Column
//     ),
//   );
// } // Directionality
