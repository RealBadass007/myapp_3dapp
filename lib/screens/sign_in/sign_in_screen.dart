import 'package:flutter/material.dart';
import 'package:myapp_3dapp/components/no_account_text.dart';
import 'package:myapp_3dapp/size_config.dart';
import 'package:myapp_3dapp/screens/sign_in/components/sign_form.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor:Color(0xff00a86b),
      ),

      body: Body(),
    );
  }
}
