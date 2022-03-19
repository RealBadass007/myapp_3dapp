import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DatabaseService{

  //final String uid;
  //static bool exist = false;
  bool newUser = false;
  //DatabaseService({this.uid});

  CollectionReference user_data_ref = FirebaseFirestore.instance.collection('user_cred');

  Future updateUserSignUpData ({String user_uid, String email, String first_name, String last_name, String address, String ph_number }) async {
    print("InUpdate");
    return await user_data_ref
        .doc(user_uid)
        .set({
          'uid' : user_uid,
          'email' : email,
          'First Name' : first_name,
          'Last Name' : last_name,
          'Address' : address,
          'Phone Number' : ph_number,
        });
  }

  Future getUsersData({String user_uid}) async {
    Map userData = {};
    try {
      await user_data_ref.doc(user_uid).get().then((DocumentSnapshot doc) {
        userData = doc.data();
        //print("Here");
        //print(userData);
      });
      return userData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> UploadCSV() async {

    //print("In Upload");

    File file = File("/storage/emulated/0/Download/Testing.xlsx");

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/Testing_${DateTime.now()}.xlsx')
          .putFile(file);
      return "Excel Uploaded";
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  /*
  /// Check If New Sign In
  Future<bool> newSignIn(String docID) async {
    try {
      await users.doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      exist = false;
      return exist;
    }
  }

   */
}