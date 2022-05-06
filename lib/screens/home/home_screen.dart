import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_3dapp/widgets/custom_bottom_navigation_bar.dart';

import '../../contacts_screen.dart';
import '../focus_screen.dart';
import '../relax_screen.dart';
import '../sleep_screen.dart';

int currentIndex = 0;
PageController pageController = PageController(initialPage: currentIndex);

class HomePage extends StatefulWidget {
  final AppBar appBar;

  HomePage({Key key, @required this.appBar}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfface2d3),
      appBar: AppBar(
        title: Text(' '),
        centerTitle: true,
        backgroundColor: Color(0xfface2d3),
        elevation: 0.0,

      ),
      body: Column(
        children: [
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                RelaxScreen(),
                ContactsScreen(),
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