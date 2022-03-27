import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/bsst_screen.dart';
import 'package:myapp_3dapp/screens/dsst_screen.dart';
import 'package:myapp_3dapp/screens/itt_screen.dart';

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
            child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child:Text(
                      'Practice Tests',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                      ),
                    ),),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child:Text(
                      'These responses will not be recorded',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 1.0,
                      ),
                    ),),
                  SizedBox(height: 50.0),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: Ink(
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          width: 280.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: true ? BoxShape.rectangle : BoxShape.circle,
                            borderRadius: true
                                ? BorderRadius.all(Radius.circular(8.0))
                                : null,
                          ),
                          child: TextButton(
                            child: const Text('Digit Symbol Substitution', style: TextStyle(color: Colors.blue, fontSize: 20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new DsstScreen(test_type: "Practice",)));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child:Text(
                      'Test 1',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 1.0,
                      ),
                    ),),
                  SizedBox(height: 30.0),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: Ink(
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          width: 280.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: true ? BoxShape.rectangle : BoxShape.circle,
                            borderRadius: true
                                ? BorderRadius.all(Radius.circular(8.0))
                                : null,
                          ),
                          child: TextButton(
                            child: const Text('Brief Stop Signal', style: TextStyle(color: Colors.blue, fontSize: 20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new BsstScreen(test_type: "Practice",)));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child:Text(
                      'Test 2',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 1.0,
                      ),
                    ),),

                  SizedBox(height: 30.0),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child:Ink(
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          width: 280.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: true ? BoxShape.rectangle : BoxShape.circle,
                            borderRadius: true
                                ? BorderRadius.all(Radius.circular(8.0))
                                : null,
                          ),
                          child: TextButton(
                            child: const Text('Inspection Time', style: TextStyle(color: Colors.blue, fontSize: 20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ITTScreen(test_type: "Practice",)));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child:Text(
                      'Test 3',
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
      ),

    );
  }
}