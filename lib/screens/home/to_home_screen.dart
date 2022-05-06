import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens/itt_screen.dart';

import '../../custom_drawer.dart';
import '../../custom_drawer_guitar.dart';
import '../../custom_routes.dart';
import 'home_screen.dart';

class ToHomeScreen extends StatelessWidget {

  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    bool flip = false;
    AppBar appBar = flip
        ? AppBar()
        : AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => CustomDrawer.of(context).open(),
          );
        },
      ),
      // title: Text('.....'),
    );
    Widget child = HomePage(appBar: appBar);
    //Widget child = CardScreen();
    // if (flip) {
    child = CustomGuitarDrawer(child: child);
    // }
    //    else {
    // child = CustomDrawer(child: child);
    //   }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '5D App',
      routes: customRoutes,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:child,
    );
  }
}