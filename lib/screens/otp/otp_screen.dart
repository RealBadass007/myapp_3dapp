import 'package:flutter/material.dart';
import 'package:myapp_3dapp/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        backgroundColor:Color(0xff00a86b),
      ),
      body: Body(),
    );
  }
}
