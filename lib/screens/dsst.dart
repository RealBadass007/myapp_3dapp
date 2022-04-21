import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bsst_screen.dart';

const double icon_size = 50.0;

int dsst_levels = 5;

Map<int, Widget> icon_map = {
  1: const Icon(Icons.nfc_rounded, size: icon_size),
  2: const Icon(Icons.cloud, size: icon_size),
  3: const Icon(Icons.camera_rounded, size: icon_size),
  4: const Icon(Icons.airport_shuttle_rounded, size: icon_size),
  5: const Icon(Icons.event_available, size: icon_size),
  6: const Icon(Icons.dvr, size: icon_size),
  7: const Icon(Icons.apps_rounded, size: icon_size),
  8: const Icon(Icons.business_center_rounded, size: icon_size),
  9: const Icon(Icons.ac_unit_rounded, size: icon_size),
};

Set generateDsstArray(int len) {
  //Set rndDsstSet = Set();
  List rndDsst = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  rndDsst.shuffle();

  Set rndDsstSet = rndDsst.take(dsst_levels).toSet();
  print('rndDsstSet: ${rndDsstSet}');

  return rndDsstSet;
}

class DsstScreen extends StatefulWidget {
  @override
  State<DsstScreen> createState() => _DsstScreenState();
}

class _DsstScreenState extends State<DsstScreen> {
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  int taskNo = -1;
  int time = 0;
  Timer timer;
  Stopwatch s = new Stopwatch();

  List rndDsstArr = (generateDsstArray(dsst_levels)).toList();

  List userDsstArr = [];
  List userDsstReactArr = [];

  bool startTest = false;
  bool waiting = false;
  bool allowButton = false;

  startTimer() {
    s.start();
    //print("Started");
  }

  stopTimer() {
    s.stop();
    time = s.elapsedMilliseconds;
    userDsstReactArr.add(time);
    s.reset();
  }

  regulate() {
    taskNo++;
    if (taskNo == dsst_levels) {
      print("userDsstArr: ${userDsstArr}");
      print("userDsstReactArr: ${userDsstReactArr}");

      int DsstErrors = calcError(userDsstArr, rndDsstArr);

      print("BsstErrors: ${DsstErrors}");

      var dsst_results = {"dsst_levels": dsst_levels, "dsst_arr": userDsstReactArr, "dsst_err": DsstErrors,};

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new BsstScreen(dsst_results: dsst_results)
          ));

    } else if (startTest && waiting) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (this.mounted){
          setState(() {
            waiting = false;
          });
        }
      });
    }
  }

  int calcError(List userDsstArr, List rndDsstArr) {
    int errors = 0;
    for (int i = 0; i < rndDsstArr.length; i++) {
      if (userDsstArr[i] != rndDsstArr[i]) {
        errors += 1;
      }
    }
    return errors;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: const Color(0xfface2d3),
        body: Container(child: Theme(
          data: ThemeData.light(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (!startTest) ...[
                    LayoutBuilder(
                        builder: (context, constraints) => Container(
                          constraints: new BoxConstraints(
                              maxHeight: 300,
                              maxWidth: constraints.maxWidth),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        startTest = true;
                                        waiting = true;
                                        print("Started");
                                        regulate();
                                      });
                                    },
                                    child: const Text('Start Test'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    color: Colors.white54,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Instructions", style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight. bold)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('''
                                            1. Each round, a symbol will be displayed within the 
                                                circular displayer.
                                            2. Map this symbol to its corresponding number pair 
                                                using the reference list provided.
                                            3. Press the button containing that number''', style: TextStyle(color: Colors.black54))),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text("2. Map this symbol to its corresponding number pair using the reference list provided."),
                                  // Text("3. Press the button containing that number"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    color: Colors.white54,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.7,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.7,
                                    child: Image.asset(
                                      'assets/dsst_info.png',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      color: Colors.white54,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.7,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.90,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Wrong Response", style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight. bold)),
                                          Text("Cloud -> 8"),
                                          Image(
                                            image: AssetImage('assets/dsst_eg_1.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      color: Colors.white54,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.7,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.90,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Correct Response", style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight. bold)),
                                          Text("Cloud -> 2"),
                                          Image(
                                            image: AssetImage('assets/dsst_eg_2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                  ] else ...[
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      height: MediaQuery.of(context).size.height * 0.24,
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (startTest && waiting) ...[
                                const SizedBox.shrink(),
                              ] else ...[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder<Widget>(
                                      future: displayIcon(taskNo, icon_map),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          print("${snapshot.data}");
                                          startTimer();
                                          allowButton = true;
                                          //return Text("Hey");
                                          return snapshot.data;
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05),
                    //Second Row starts here
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[50],
                        //border: Border.all(color: Colors.blueAccent)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.06),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("6",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("4",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width:
                                MediaQuery.of(context).size.width * 0.025,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("9",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("8",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width:
                                MediaQuery.of(context).size.width * 0.025,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("3",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("7",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("5",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("2",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width:
                                MediaQuery.of(context).size.width * 0.025,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: TextButton(
                                        // icon: Icon(Icons.dvr),
                                        child: Text("1",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.grey[800])),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02),
                          //Third Row starts here
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.06),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.07,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.dvr),
                                      iconSize: 40.0,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.airport_shuttle_rounded),
                                      iconSize: 43,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width:
                                MediaQuery.of(context).size.width * 0.025,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.ac_unit_rounded),
                                      iconSize: 40,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.business_center_rounded),
                                      iconSize: 40,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width:
                                MediaQuery.of(context).size.width * 0.025,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_rounded),
                                      iconSize: 40,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.apps_rounded),
                                      iconSize: 40.5,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.event_available),
                                      iconSize: 40,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.025),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.cloud),
                                      iconSize: 40,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width:
                                MediaQuery.of(context).size.width * 0.025,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.075,
                                height: MediaQuery.of(context).size.height *
                                    0.1125,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Color(0xfface2d3),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.nfc_rounded),
                                      iconSize: 40,
                                      disabledColor: Colors.grey[800],
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    ),

                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.05),
                    //Fourth Row starts here
                    Row(
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("1",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 1");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(1);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                                // },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("2",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 2");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(2);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("3",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 3");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(3);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("4",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 4");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(4);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("5",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 5");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(5);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("6",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 6");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(6);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("7",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 7");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(7);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.025),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("8",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 8");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(8);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.075,
                          height: MediaQuery.of(context).size.height * 0.135,
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(),
                              ),
                              child: ElevatedButton(
                                // icon: Icon(Icons.looks_4_outlined),
                                child: Text("9",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800])),
                                // label: Text(""),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[100]),
                                onPressed: () {
                                  print("Button 9");
                                  if (userDsstArr.length == taskNo &&
                                      allowButton) {
                                    userDsstArr.add(9);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      allowButton = false;
                                      regulate();
                                      //stop timer here
                                    });
                                  }
                                  ;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ], //Fourth Row ends here
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  Future<Widget> displayIcon(int taskNo, Map iconMap) async {
    print("taskNo: ${taskNo}");
    //print(iconMap);
    return await iconMap[rndDsstArr[taskNo]];
  }
}
