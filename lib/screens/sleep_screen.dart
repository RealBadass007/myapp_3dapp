import 'package:flutter/material.dart';
import 'dart:math';
import 'package:myapp_3dapp/components/form_error.dart';
import 'package:myapp_3dapp/constants.dart';
import 'package:myapp_3dapp/screens/profile/widgets/card_item.dart';
import 'package:myapp_3dapp/screens/profile/widgets/stack_container.dart';
Random random = new Random();
int randomNumber = random.nextInt(10);
var arr = ['aardvark','attorney','concrete','bacteria','bulletin','dialogue','endeavor','magazine','observer','progress','sequence'];
class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xfface2d3),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CardItem(),
              shrinkWrap: true,
              itemCount: 1,
            )
          ],
        ),
      ),
    );
  }
}
