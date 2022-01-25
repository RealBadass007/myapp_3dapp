import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/splash/splash_screen.dart';

import '../../custom_routes.dart';

class ToSplashScreen extends StatelessWidget {

  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {

    Widget child = SplashScreen();
    // if (flip) {
    //child = CustomGuitarDrawer(child: child);
    // }
    //    else {
    // child = CustomDrawer(child: child);
    //   }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D3 App',
      routes: customRoutes,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:child,
    );
  }
}