import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/complete_profile/complete_profile_screen.dart';

import '../../custom_routes.dart';

class ToCompleteProfileScreen extends StatelessWidget {

  static String routeName = "/to_complete_profile";
  @override
  Widget build(BuildContext context) {

    Widget child = CompleteProfileScreen();
    // if (flip) {
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