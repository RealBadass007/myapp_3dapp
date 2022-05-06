import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp_3dapp/services/database_service.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';

class UberScreen extends StatelessWidget {

  // This widget is the root
  // of your application

  @override
  Widget build(BuildContext context) {

    final firebaseUser = context.watch<User>();
    DatabaseService dbs = new DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          " ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xfface2d3),
        centerTitle: true,
      ),


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
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        width: 280.0,
                        height: 150.0,
                        child: FutureBuilder(
                          future: dbs.getUsersData(user_uid: firebaseUser.uid),
                          builder: (context, snapshot) =>
                          Container(
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
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              color: Colors.grey[600],
                              iconSize: 100,
                              onPressed: () {

                                print("${snapshot.data}");

                                String lat = snapshot.data['Address Latitude'];
                                String lng = snapshot.data['Address Longitude'];

                                String url = "https://olawebcdn.com/assets/ola-universal-link.html?drop_lat= ${lat} &drop_lng=${lng}";
                                launch(url);

                                // final intent = AndroidIntent(package: "com.google.maps.android", action: "action_view");
                                // intent.launch();

                                /*
                                //final intent = AndroidIntent(package: "com.olacabs.customer", action: "action_view");
                                //final intent = AndroidIntent(package: "com.ubercab", action: "action_view");
                                //intent.launch();

                                 */

                                },
                            ),
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

                            icon: Image.asset('assets/share_location.png'), //Icon(Icons.directions_car),
                            padding: EdgeInsets.all(8.0),
                            constraints: BoxConstraints(),
                            color: Colors.grey[600],
                            iconSize: 100,


                            onPressed: () async {

                              //LocationPermission permission = await Geolocator.checkPermission();
                              Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

                              String currLat = position.latitude.toString();
                              String currLng = position.longitude.toString();

                              //print(currLat);
                              //print(currLng);


                              String url = "https://wa.me/?text=Can you pick me up at this location? \n https://maps.app.goo.gl/?link=https://www.google.com/maps/place/${currLat},${currLng}";
                              var encoded = Uri.encodeFull(url);
                              //print(encoded);
                              //var encoded =  url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
                              launch(encoded);

                              /*
                                Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new TypeScreen())
                            );

                               */
                            },



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
                    'Share your Location',
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

  _openJioSavaan (data) async
  {String dt = data['JioSavaan'] as String;
  bool isInstalled = await DeviceApps.isAppInstalled('com.jio.media.jiobeats');
  if (isInstalled != false)
  {
    AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: dt
    );
    await intent.launch();
  }
  else
  {
    String url = dt;
    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';
  }
  }
}