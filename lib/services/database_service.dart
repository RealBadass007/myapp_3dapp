import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class DatabaseService{

  //final String uid;
  //static bool exist = false;
  bool newUser = false;
  //DatabaseService({this.uid});
  static var httpClient = new HttpClient();

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

  Future updateTestDate ({String user_uid, String test_result}) async {
    print("InUpdateTestDate");
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('h:mm a' ).format(now);
    return await user_data_ref
        .doc(user_uid)
        .update({
      'Prev Test Date' : formattedDate.trim(),
      'Prev Test Time'  : formattedTime.trim(),
      'Prev Test Result' : test_result.trim(),
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

  Future<bool> CheckModel() async {
    final fileName = 'intoxication_classifier.json';
    bool fileExists = await File('/storage/emulated/0/Android/data/com.example.myapp_3dapp/files/' + fileName).exists();

    if (!fileExists){
      DownloadModel();
    }
  }

  Future DownloadModel() async {
    final String url = 'https://firebasestorage.googleapis.com/v0/b/tcet-a16-5dapp.appspot.com/o/model%2Fintoxication_classifier.json?alt=media&token=6108a7f0-2039-49cb-bde9-19261a3db3fa';
    final fileName = 'intoxication_classifier.json';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    File file = File('/storage/emulated/0/Android/data/com.example.myapp_3dapp/files/' + fileName);

    //final body = json.decode(response.body);

    await file.writeAsBytesSync(bytes);
  }

  Future UploadModel() async {

    //print("In Upload");

    final fileName = 'intoxication_classifier.json';
    File file = File('/storage/emulated/0/Android/data/com.example.myapp_3dapp/files/' + fileName);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('model/' + fileName)
          .putFile(file);
      //return "Model Uploaded";
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<String> UploadCSV() async {

    //print("In Upload");

    File file = File("/storage/emulated/0/Download/5D_App_Testing.xlsx");

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('testing/Testing_${DateTime.now()}.xlsx')
          .putFile(file);
      return "Excel Uploaded";
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}