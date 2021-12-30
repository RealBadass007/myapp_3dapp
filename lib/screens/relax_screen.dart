import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/card_screen.dart';
import 'package:myapp_3dapp/screens/type_screen.dart';
import 'package:myapp_3dapp/screens/uber_screen.dart';

class RelaxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        width: 280.0,
                        height: 150.0,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape:
                            true ? BoxShape.rectangle : BoxShape.circle,
                            borderRadius: true
                                ? BorderRadius.all(Radius.circular(8.0))
                                : null,

                          ),
                          child: IconButton(

                            icon: Image.asset('assets/taxi.png'), //Icon(Icons.directions_car),
                            color: Colors.grey[600],
                            iconSize: 100,
                            onPressed: () { Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new UberScreen())
                            ); },
                          ),
                        ),
                      ),
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
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  ),),
                SizedBox(height: 35.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Ink(

                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        width: 280.0,
                        height: 150.0,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape:
                            true ? BoxShape.rectangle : BoxShape.circle,
                            borderRadius: true
                                ? BorderRadius.all(Radius.circular(8.0))
                                : null,

                          ),
                          child: IconButton(

                            icon: Image.asset('assets/test.png'), //Icon(Icons.directions_car),
                            color: Colors.grey[600],
                            iconSize: 100,

                            onPressed: () { Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new TypeScreen())
                            ); },


                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                  child:Text(
                    'Take The Test',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
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