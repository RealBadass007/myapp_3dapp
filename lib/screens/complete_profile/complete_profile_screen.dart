import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";

  final String temail;
  final String tpassword;

  CompleteProfileScreen({this.temail, this.tpassword});

  @override
  Widget build(BuildContext context) {

    final routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final temail = routeData['temail'];
    final tpassword = routeData['tpassword'];

    //print("cps = ${temail}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor:Color(0xff00a86b),
      ),
      body: Body(temail : temail, tpassword: tpassword),
    );
  }
}