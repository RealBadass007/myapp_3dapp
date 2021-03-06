import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/dsst.dart';

import 'package:myapp_3dapp/screens/uber_screen.dart';

class RelaxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfface2d3),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Ink(
                        child: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            width: 280.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: true ? BoxShape.rectangle : BoxShape.circle,
                              borderRadius: true
                                  ? BorderRadius.all(Radius.circular(8.0))
                                  : null,
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                  'assets/map.png'), //Icon(Icons.directions_car),
                              padding: EdgeInsets.all(8.0),
                              constraints: BoxConstraints(),
                              color: Colors.grey[600],
                              iconSize: 100,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new UberScreen()));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Location Services',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Ink(
                        child: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            width: 280.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: true ? BoxShape.rectangle : BoxShape.circle,
                              borderRadius: true
                                  ? BorderRadius.all(Radius.circular(8.0))
                                  : null,
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                  'assets/test.png'), //Icon(Icons.directions_car),
                              padding: EdgeInsets.all(8.0),
                              constraints: BoxConstraints(),
                              color: Colors.grey[600],
                              iconSize: 100,

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            //new ITTScreen())
                                            //new BsstScreen())
                                            new DsstScreen())
                                            //new InfoScreen())
                                    //new CustomProgressIndicator())
                                    );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Take The Test',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
