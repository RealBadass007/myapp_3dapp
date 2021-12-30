import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/progress_screen.dart';



Random random = new Random();
int randomNumber = random.nextInt(10);
var arr = ['aardvark','attorney','concrete','bacteria','bulletin','dialogue','endeavor','magazine','observer','progress','sequence'];
class TypeScreen extends StatefulWidget {
  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfface2d3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                arr[randomNumber],
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            SizedBox(height: 100.0),
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color:  Color(0xff00a86b).withAlpha(150),
                      blurRadius: 20.0,
                      offset: Offset(0, 10)
                  )
                  //


                ],
              ),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,

                ),
              ),
            ),
            SizedBox(height: 70.0),
            Center(
              child: SizedBox(
                width: 180,
                height: 60,
                child: RaisedButton(
                  child: Text("Continue"),
                  disabledColor:Color(0xff00a86b).withAlpha(175),
                  disabledTextColor: Colors.white,
                  textColor: Colors.white,
                  color:Color(0xff00a86b).withAlpha(255) ,
                  splashColor: Color(0xfface2d3),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new CustomProgressIndicator())
                    );
                    // level *= 2;
                  },
                  // animationDuration: Duration(seconds: 2),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
