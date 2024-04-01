import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProviderModel {
  final String? id;
  final String fullName;
  final String email;
  final String? phoneNo;
  final String password;
  final String? imageLink;

  const ProviderModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    this.phoneNo,
    this.imageLink
  });

  //firebase does not stores data directly we need to convert data into json format
  toJson() {
    return {
      "id" : FirebaseAuth.instance.currentUser!.uid,
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "ImageLink":imageLink
    };
  }

  //fetching model
  // Map user fetched from firebase to userModel
  factory ProviderModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data()!;//.data provides complete object .get provides particular value e.g. email
        return ProviderModel(
            id: document.id,
            email: data["Email"],//here "Email" is namne of column in database
            password: data["Password"],
            fullName: data["FullName"],
            phoneNo: data["Phone"],
          imageLink:data["ImageLink"]
        );
  }
}
