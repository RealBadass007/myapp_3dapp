import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp_3dapp/screens/home/to_home_screen.dart';
import 'package:myapp_3dapp/screens/splash/to_splash_screen.dart';
import 'package:provider/src/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final firebaseUser = context.watch<User>();
    print(firebaseUser);

    if (firebaseUser != null) {
      /*
    }
        var test = DatabaseService().checkExist(firebaseUser.uid);
        print("test = ${test}");
        if(test){
          print("inside if DatabaseService.exist");

       */
          return ToHomeScreen();
        }
    else {
      return ToSplashScreen();
    }
  }
}