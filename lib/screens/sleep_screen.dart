import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:myapp_3dapp/screens/profile/widgets/card_item.dart';
import 'package:myapp_3dapp/screens/profile/widgets/stack_container.dart';
import 'package:myapp_3dapp/services/database_service.dart';
import 'package:provider/src/provider.dart';
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

    final firebaseUser = context.watch<User>();
    DatabaseService ds = new DatabaseService();

    return Scaffold(
      backgroundColor:  Color(0xfface2d3),
      body: Center(
      child: FutureBuilder<dynamic>(
        future: ds.getUsersData(user_uid: firebaseUser.uid), // a previously-obtained Future<String> or null
        builder: (context, snapshot){

          List<Widget> children;
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                StackContainer(snapshot: snapshot),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CardItem(snapshot: snapshot),
                  shrinkWrap: true,
                  itemCount: 1,
                )
              ],
            );
          } else if (snapshot.hasError) {
            print("Error in sleep_screen");
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
              ),
          );
          //return Text("${snapshot.data['Email']}");
      },
      ),

        /*
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

         */
      ),
    );
  }
}
