import 'package:myapp_3dapp/custom_drawer_guitar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_3dapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:myapp_3dapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:myapp_3dapp/screens/login_success/login_success_screen.dart';
import 'package:myapp_3dapp/screens/otp/otp_screen.dart';
import 'package:myapp_3dapp/screens/sign_in/sign_in_screen.dart';
import 'package:myapp_3dapp/screens/sign_up/sign_up_screen.dart';
import 'package:myapp_3dapp/screens/splash/splash_screen.dart';
import 'contacts_screen.dart';
import 'screens/home.dart';
import 'custom_drawer.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'screens/focus_screen.dart';
import 'screens/relax_screen.dart';
import 'screens/sleep_screen.dart';
import 'package:myapp_3dapp/size_config.dart';
import 'main.dart';

PageController pageController = PageController(initialPage: 0);
int currentIndex = 0;

class HomeScreen extends StatefulWidget {

  final AppBar appBar;

  HomeScreen({Key key, @required this.appBar}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfface2d3),
      appBar: AppBar(
        title: Text(' '),
        centerTitle: true,
        backgroundColor: Color(0xfface2d3),
        elevation: 0.0,

        actions: <Widget>[

          // PopupMenuButton<String>(
          //   onSelected: choiceAction,
          //   itemBuilder: (BuildContext context){
          //     return Constants.choices.map((String choice){
          //       return PopupMenuItem<String>(
          //         value: choice,
          //
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // )
        ],
      ),
      body: Stack(
        children: [
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                FocusScreen(),
                RelaxScreen(),
                SleepScreen(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar:CustomBottomNavigationBar(),

    );
  }
}