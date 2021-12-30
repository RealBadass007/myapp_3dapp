import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/splash/components/body.dart';
import 'package:myapp_3dapp/size_config.dart';

class SplashScreen1 extends StatelessWidget {
  static String routeName = "/splash1";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(

      appBar: AppBar(
        title: Text(
          " ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xff00a86b),
        centerTitle: true,
      ),
      // backgroundColor: Color(0xfface2d3),
      body: Body(),
    );
  }
}