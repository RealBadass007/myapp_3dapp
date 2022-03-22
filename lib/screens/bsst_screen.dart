import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'itt_screen.dart';

int bsst_levels = 5;

List generateBsstArray(int len) {
  var rnd = Random();
  List rndBsstArr = [];
  for (int i = 0; i < len; i++) {
    rndBsstArr.add(rnd.nextInt(2));
  }
  print(rndBsstArr);
  return rndBsstArr;
}

class BsstScreen extends StatefulWidget {

  final Map dsst_results;

  const BsstScreen({this.dsst_results});
  @override
  _BsstScreenState createState() => _BsstScreenState();
}

class _BsstScreenState extends State<BsstScreen> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;

  int taskNo = -1;

  bool startTest = false;
  bool waiting = false;
  bool allowButton = false;

  final String bsst_left = 'assets/bsst_left.svg';
  final String bsst_right = 'assets/bsst_right.svg';
  final String bsst_miss = 'assets/bsst_miss.svg';

  Future<Widget> delayed;

  int time = 0;
  Timer timer;
  Stopwatch s = new Stopwatch();

  List rndBsstArr = generateBsstArray(bsst_levels);
  List userBsstArr = [];
  List userBsstReactArr = [];

  var rnd = Random();

  bool permissionGranted = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Widget generateArrow(int lf, ittFigMap) {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: SvgPicture.asset(
          ittFigMap[lf],
          height: 150,
          width: 150,
        ));
  }

  startTimer() {
    s.start();
    //print("Started");
  }

  stopTimerMiss() {
    s.stop();
    time = s.elapsedMilliseconds;
    userBsstReactArr.add(-1);
    s.reset();
  }

  stopTimer() {
    s.stop();
    time = s.elapsedMilliseconds;
    userBsstReactArr.add(time);
    s.reset();
    //print("Stop & Reset");
  }

  miss_regulate() {
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        waiting = true;
        regulate();
      });
    });
  }

  regulate() {
    taskNo++;
    if (taskNo == bsst_levels) {

      print("userBsstArr: ${userBsstArr}");
      print("userBsstReactArr: ${userBsstReactArr}");

      List BsstErrorsMisses = calcError(userBsstArr, rndBsstArr);

      int BsstErrors = BsstErrorsMisses[0];
      int BsstMisses = BsstErrorsMisses[1];

      print("BsstErrors: ${BsstErrors}, BsstMisses: ${BsstMisses}");

      Future _getStoragePermission() async {
        if (await Permission.storage.request().isGranted) {
          setState(() {
            permissionGranted = true;
          });
        }
      }

      _getStoragePermission();

      var bsst_results = {"bsst_levels": bsst_levels, "bsst_arr": userBsstReactArr, "bsst_err": BsstErrors, "bsst_misses": BsstMisses};

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ITTScreen(dsst_results: widget.dsst_results, bsst_results: bsst_results)
          ));

      //TO DO

      // Navigator.push(context, new MaterialPageRoute(
      //     builder: (context) =>
      //     new CustomProgressIndicator(itt_arr: userReactArr, itt_err: errors))
      // );

    } else if (startTest && waiting) {
      int random_wait = 650 + rnd.nextInt(2500 - 650);
      Future.delayed(Duration(milliseconds: random_wait), () {
        setState(() {
          waiting = false;
        });
      });
    }
  }

  List calcError(List userBsstArr, List rndBsstArr) {
    int errors = 0;
    int misses = 0;
    for (int i = 0; i < rndBsstArr.length; i++) {
      if (userBsstArr[i] == -1) {
        misses += 1;
      } else if (userBsstArr[i] != rndBsstArr[i]) {
        errors += 1;
      }
    }
    return [errors, misses];
  }

  @override
  Widget build(BuildContext context) {
    var BsstFigMap = {0: bsst_left, 1: bsst_right};

    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Color(0xfface2d3),
        body: SafeArea(
          child: Center(
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
                        //SvgPicture.asset(itt_left, height:350, width:350,),
                        if (!startTest) ...[
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
                        ]
                        // else if(startTest && waiting)...[
                        //     SizedBox.shrink(),
                        // ]
                        else ...[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(200, 80)),
                                onPressed: () {
                                  //startTest = false;
                                  if (userBsstArr.length == taskNo &&
                                      allowButton) {
                                    print("Left");
                                    userBsstArr.add(0);
                                    stopTimer();
                                    allowButton = false;
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
                              Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                    color: Colors.white60,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 5,
                                    )),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      if (startTest && waiting) ...[
                                        SizedBox.shrink(),
                                      ] else if (startTest && !waiting) ...[
                                        FutureBuilder(
                                          future: Future.delayed(
                                              Duration(milliseconds: 500),
                                              () => "Missed"),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == "Missed") {
                                              //startTimer();
                                              print("Missed");
                                              allowButton = false;
                                              userBsstArr.add(-1);
                                              stopTimerMiss();
                                              miss_regulate();
                                              return SvgPicture.asset(
                                                bsst_miss,
                                                height: 200,
                                                width: 200,
                                              );
                                              //Text("Missed"),
                                            } else {
                                              print("Not Missed Yet");
                                              allowButton = true;
                                              startTimer();
                                              return generateArrow(
                                                  rndBsstArr[taskNo], BsstFigMap);
                                              //return SvgPicture.asset(itt_right, height:350, width:350,);
                                            }
                                            //SvgPicture.asset(itt_mask, height:350, width:350,);
                                          },
                                        ),
                                      ]
                                    ]),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(200, 80)),
                                onPressed: () {
                                  //startTest = false;
                                  if (userBsstArr.length == taskNo &&
                                      allowButton) {
                                    print("Right");
                                    userBsstArr.add(1);
                                    stopTimer();
                                    allowButton = false;
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
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // showResult() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => AlertDialog(
  //       title: Text("           "),
  //       content: Text(
  //         "Time $time",
  //         style: Theme.of(context).textTheme.headline3,
  //       ),
  //       actions: <Widget>[
  //         FlatButton(
  //           onPressed: () {
  //             Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(
  //                 builder: (context) => TypeScreen(
  //                   // size: level,
  //                 ),
  //               ),
  //             );
  //             // level *= 2;
  //           },
  //           child: Text("NEXT"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
