import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/type_screen.dart';
import 'package:myapp_3dapp/screens/uber_screen.dart';

class FocusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Color(0xfface2d3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
          child:Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Ink(

                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(

                      icon: Icon(Icons.directions_car),
                      color: Colors.grey[600],
                      onPressed: () {Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>
                          new UberScreen())
                      ); },
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Text(
                    'Call A Cab',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 1.0,
                    ),
                  ),),
                SizedBox(height: 60.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Ink(

                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(

                      icon: Icon(Icons.dvr),
                      color: Colors.grey[600],
                      onPressed: () { Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>
                          new TypeScreen())
                      ); },
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Text(
                    'Retake The Test',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 1.0,
                    ),
                  ),),

                SizedBox(height: 60.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Ink(

                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(

                      icon: Icon(Icons.call_sharp),
                      color: Colors.grey[600],
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Text(
                    'Call An Emergency Contact',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 1.0,
                    ),
                  ),),


              ],
            ),
          ),
        ),
      ),

    );
  }
}