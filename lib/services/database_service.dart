import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  //final String uid;
  //static bool exist = false;
  bool newUser = false;
  //DatabaseService({this.uid});


  CollectionReference users = FirebaseFirestore.instance.collection('user_cred');

  Future updateUserSignUpData ({String user_uid, String email, String first_name, String last_name, String address, String ph_number }) async {
    print("InUpdate");
    return await users
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