import 'dart:async';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:myapp_3dapp/screens//type_screen.dart';
import 'package:myapp_3dapp/screens/progress_screen.dart';
import 'package:myapp_3dapp/services/excel_service.dart';
import 'package:permission_handler/permission_handler.dart';

int turns = 4;

List generateIttArray (int len) {
  var rnd = Random();
  List rndIttArr = [];
  for(int i = 0 ; i < len ; i ++ ){
    rndIttArr.add(rnd.nextInt(2));
  }
  print(rndIttArr);
  return rndIttArr;
}

class ITTScreen extends StatefulWidget {
  final int size;

  const ITTScreen({Key key, this.size = 12}) : super(key: key);
  @override
  _ITTScreenState createState() => _ITTScreenState();
}

class _ITTScreenState extends State<ITTScreen> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;

  int taskNo= -1;

  bool startTest = false;
  bool waiting = false;

  final String itt_left = 'assets/itt_left.svg';
  final String itt_right = 'assets/itt_right.svg';
  final String itt_mask = 'assets/itt_mask.svg';

  Future<Widget> delayed;

  int time = 0;
  Timer timer;
  Stopwatch s = new Stopwatch();

  List rndIttArr = generateIttArray(turns);
  List userIttArr = [];
  List userReactArr = [];

  bool permissionGranted = false;

  @override
  void initState() {
    super.initState();
    //initFutures();
    /*
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }

     */
    //data.shuffle();
    //startTimer();
  }

  /*
  void initFutures() {
    delayed = Future.delayed(Duration(milliseconds: 1850), () async => await SvgPicture.asset(itt_mask, height:350, width:350,) );
  }
  */

  Widget generatePiFigure (int lf, ittFigMap){
    return SvgPicture.asset(ittFigMap[lf], height:350, width:350,);
  }

  startTimer() {
    s.start();
    //print("Started");
  }

  stopTimer() {
    s.stop();
    time = s.elapsedMilliseconds;
    userReactArr.add(time);
    s.reset();
    //print("Stop & Reset");
  }

  /*
  startTimer() {
    Stopwatch s = new Stopwatch();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (this.mounted && startTest) {
        s.start();
        setState(() {
          time = s.elapsedMilliseconds;
          //time = time + 1;
        });
      }
    });
  }

   */

  regulate(){
    taskNo ++;
    if(taskNo == turns) {
      print(userIttArr);
      print(userReactArr);
      int errors = calcError(userIttArr, rndIttArr);
      print(errors);

      Future _getStoragePermission() async {
        if (await Permission.storage.request().isGranted) {
          setState(() {
            permissionGranted = true;
          });
        }
      }

      _getStoragePermission();

      //ExcelServices.CreateCSV(userReactArr, errors);

      Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
          new CustomProgressIndicator(itt_arr: userReactArr, itt_err: errors))
      );
    }
    else if(startTest && waiting){
        Future.delayed(Duration(milliseconds: 1500), () {
          setState(() {
            waiting= false;
          });
        });
    }
  }



  int calcError(List userIttArr, List rndIttArr){
    int errors = 0;
    for (int i = 0 ; i < rndIttArr.length ; i++){
        if(userIttArr[i] != rndIttArr[i]){
            errors += 1;
        }
    }
    return errors;
  }

  @override
  Widget build(BuildContext context) {

    var ittFigMap = {0:itt_left, 1: itt_right};

    return Scaffold(
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
                    children: <Widget> [

                      //SvgPicture.asset(itt_left, height:350, width:350,),
                      if(!startTest)...[
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
                      ]else if(startTest && waiting)...[
                          SizedBox.shrink(),
                      ]else...[
                          FutureBuilder <Widget> (
                            future: Future.delayed(Duration(milliseconds: 100), () async => await SvgPicture.asset(itt_mask, height:350, width:350,)),
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                startTimer();
                                return snapshot.data;
                              }
                              else{
                                return generatePiFigure(rndIttArr[taskNo], ittFigMap);
                                //return SvgPicture.asset(itt_right, height:350, width:350,);
                              }
                              //SvgPicture.asset(itt_mask, height:350, width:350,);
                            },
                          ),
                          SizedBox(height: 40,),
                          Row(
                            children: <Widget> [
                              Expanded(child: ElevatedButton(
                                style: ElevatedButton.styleFrom(fixedSize: const Size(200 ,50)),
                                onPressed: () {
                                  //startTest = false;
                                  print("Left");
                                  if(userIttArr.length == taskNo){
                                    userIttArr.add(0);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      regulate();
                                    });
                                  };
                                },
                                child: const Text('Left'),
                              )),
                              SizedBox(width: 40,),

                              Expanded(child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(200 ,50)),
                                onPressed: () {
                                  //startTest = false;
                                  print("Right");
                                  if(userIttArr.length == taskNo){
                                    userIttArr.add(1);
                                    stopTimer();
                                    setState(() {
                                      waiting = true;
                                      regulate();
                                    });
                                  };
                                },
                                child: const Text('Right'),
                              )),
                            ],
                          ),
                      ]
                    ],
                  ),
                  /*
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;
                              print(cardFlips);

                              if (cardFlips.every((t) => t == false)) {
                                print("Won");
                                showResult();
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Color(0xff00a86b).withAlpha(175),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Color(0xff00a86b).withAlpha(255),
                        child: Center(
                          child: Text(
                            "${data[index]}",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                    ),
                    itemCount: data.length,
                  ),

                   */
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