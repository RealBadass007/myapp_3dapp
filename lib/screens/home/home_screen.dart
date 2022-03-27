import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_3dapp/widgets/custom_bottom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

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

  bool permissionGranted = false;

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    Future _getStoragePermission() async {
      if (await Permission.storage.request().isGranted) {
        setState(() {
          permissionGranted = true;
        });
      }
    }

    _getStoragePermission();

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
          if(!permissionGranted)...[
            Text("Storage Permission Denied!", style: TextStyle(color: Colors.red, fontSize: 20)),
          ],
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                RelaxScreen(),
                FocusScreen(),
                //SleepScreen(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar:CustomBottomNavigationBar(),

    );
  }
}