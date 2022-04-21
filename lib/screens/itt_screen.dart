import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens//type_screen.dart';
import 'package:myapp_3dapp/screens/progress_screen.dart';
import 'package:permission_handler/permission_handler.dart';

int itt_levels = 4;

List generateIttArray(int len) {
  var rnd = Random();
  List rndIttArr = [];
  for (int i = 0; i < len; i++) {
    rndIttArr.add(rnd.nextInt(2));
  }
  print("rndIttArr: ${rndIttArr}");
  return rndIttArr;
}

class ITTScreen extends StatefulWidget {

  final Map dsst_results;
  final Map bsst_results;

  ITTScreen({this.dsst_results, this.bsst_results,});

  @override
  _ITTScreenState createState() => _ITTScreenState();
}

class _ITTScreenState extends State<ITTScreen> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;

  int taskNo = -1;

  bool startTest = false;
  bool waiting = false;

  final String itt_left = 'assets/itt_left.svg';
  final String itt_right = 'assets/itt_right.svg';
  final String itt_mask = 'assets/itt_mask.svg';

  Future<Widget> delayed;

  int time = 0;
  Timer timer;
  Stopwatch s = new Stopwatch();

  List rndIttArr = generateIttArray(itt_levels);
  List userIttArr = [];
  List userIttReactArr = [];

  bool permissionGranted = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Widget generatePiFigure(int lf, ittFigMap) {
    return SvgPicture.asset(
      ittFigMap[lf],
      height: 350,
      width: 350,
    );
  }

  startTimer() {
    s.start();
    //print("Started");
  }

  stopTimer() {
    s.stop();
    time = s.elapsedMilliseconds;
    userIttReactArr.add(time);
    s.reset();
    //print("Stop & Reset");
  }

  regulate() {
    taskNo++;
    if (taskNo == itt_levels) {

      print("userIttArr: ${userIttArr}");
      print("userIttReactArr: ${userIttReactArr}");

      int IttErrors = calcError(userIttArr, rndIttArr);

      print("IttErrors: ${IttErrors}");

      Future _getStoragePermission() async {
        if (await Permission.storage.request().isGranted) {
          setState(() {
            permissionGranted = true;
          });
        }
      }

      _getStoragePermission();

      var itt_results = {"itt_levels": itt_levels, "itt_arr": userIttReactArr, "itt_err": IttErrors};

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new CustomProgressIndicator(
                  dsst_results: widget.dsst_results, bsst_results: widget.bsst_results, itt_results: itt_results
              )
          ));
    } else if (startTest && waiting) {
      Future.delayed(Duration(milliseconds: 1000), () {
        if (this.mounted) {
          setState(() {
            waiting = false;
          });
        }
      });
    }
  }

  int calcError(List userIttArr, List rndIttArr) {
    int errors = 0;
    for (int i = 0; i < rndIttArr.length; i++) {
      if (userIttArr[i] != rndIttArr[i]) {
        errors += 1;
      }
    }
    return errors;
  }

  @override
  Widget build(BuildContext context) {
    var ittFigMap = {0: itt_left, 1: itt_right};

    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Color(0xfface2d3),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      if (!startTest) ...[
                      LayoutBuilder(builder: (context, constraints) => Container(
                        constraints: new BoxConstraints(
                            maxHeight: constraints.maxWidth * 1.8,
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
       1. A pi-diagram has 2 arms of unequal lengths.
       2. The objective of this test is to determine
           which arm is longer out of the two.
       3. The diagram will only be flashed on the
           screen for 0.1 seconds before it is masked. ''', textAlign: TextAlign.left, style: TextStyle(color: Colors.black54))),
                                      SizedBox(
                                        height: 20,
                                      ),

                                    ],
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
                                        0.9,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.95,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Diagram displayed for 0.1 second"),
                                        Text("before Masking"),
                                        Image(
                                          image: AssetImage('assets/itt_eg_1.png'),
                                          fit: BoxFit.contain,
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
                                        0.9,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.9,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("After Masking"),
                                        Image(
                                          image: AssetImage('assets/itt_eg_2.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      ),
                    ] else if (startTest && waiting) ...[
                      SizedBox.shrink(),
                    ] else ...[
                      FutureBuilder<Widget>(
                        future: Future.delayed(
                            Duration(milliseconds: 100),
                                () async => await SvgPicture.asset(
                              itt_mask,
                              height: 350,
                              width: 350,
                            )),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            startTimer();
                            return Column(
                              children: <Widget>[
                                snapshot.data,
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(200, 80)),
                                          onPressed: () {
                                            //startTest = false;
                                            print("Left");
                                            if (userIttArr.length == taskNo) {
                                              userIttArr.add(0);
                                              stopTimer();
                                              setState(() {
                                                waiting = true;
                                                regulate();
                                              });
                                            }
                                            ;
                                          },
                                          child: const Text('Left'),
                                        )),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(200, 80)),
                                          onPressed: () {
                                            //startTest = false;
                                            print("Right");
                                            if (userIttArr.length == taskNo) {
                                              userIttArr.add(1);
                                              stopTimer();
                                              setState(() {
                                                waiting = true;
                                                regulate();
                                              });
                                            }
                                            ;
                                          },
                                          child: const Text('Right'),
                                        )),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: <Widget>[
                                generatePiFigure(
                                    rndIttArr[taskNo], ittFigMap),
                                //Every Widget below is dummy
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(200, 80),
                                            primary: Colors.transparent,
                                            elevation: 0,
                                          ),
                                          onPressed: () {
                                            null;
                                          },
                                          child: const Text(''),
                                        )),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(200, 80),
                                            primary: Colors.transparent,
                                            elevation: 0,
                                          ),
                                          onPressed: () {
                                            null;
                                          },
                                          child: const Text(''),
                                        )),
                                  ],
                                ),
                              ],
                            );
                            //return SvgPicture.asset(itt_right, height:350, width:350,);
                          }
                          //SvgPicture.asset(itt_mask, height:350, width:350,);
                        },
                      ),
                    ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("           "),
        content: Text(
          "Time $time",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => TypeScreen(
                      // size: level,
                      ),
                ),
              );
              // level *= 2;
            },
            child: Text("NEXT"),
          ),
        ],
      ),
    );
  }
}
