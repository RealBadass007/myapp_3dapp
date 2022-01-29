import 'package:flutter/material.dart';
import 'package:myapp_3dapp/widgets/custom_bottom_navigation_bar.dart';

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

  /*
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

   */
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

        /*
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

         */
      ),
      body: Column(
        children: [
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                RelaxScreen(),
                FocusScreen(),
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