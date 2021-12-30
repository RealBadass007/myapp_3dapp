import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp_3dapp/models/cust_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj
  Cust_user _userFromFirebaseUser(User user) {
    return user != null ? Cust_user(uid:user.uid) : null;
  }

  // auth change user stream
  Stream<Cust_user> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}