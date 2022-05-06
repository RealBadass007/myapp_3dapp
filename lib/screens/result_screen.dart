import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:myapp_3dapp/services/database_service.dart';
import 'package:myapp_3dapp/services/excel_service.dart';
import 'package:myapp_3dapp/services/predict_user_state.dart';
import 'package:provider/src/provider.dart';

class ResultIndicator extends StatefulWidget {

  final Map dsst_results;
  final Map bsst_results;
  final Map itt_results;

  ResultIndicator({this.dsst_results, this.bsst_results, this.itt_results});

  @override
  _ResultIndicatorState createState() =>
      _ResultIndicatorState();
}

class _ResultIndicatorState extends State<ResultIndicator> {
  double _height;
  double _width;

  double percent = 0.0;

  bool proceed = false;

  bool creating_excel = false;

  bool created_excel = false;

  ExcelServices es = new ExcelServices();

  DatabaseService ds = new DatabaseService();

  // Future<String> CreateCSV() async {
  //   return await es.CreateCSV(widget.dsst_results, widget.bsst_results, widget.itt_results);
  // }

  // deleteFile() async {
  //   return await es.DeleteCSV();
  // }

  // bool AcceptableErrNMissCount() {
  //   if (widget.dsst_results['dsst_err'] + widget.bsst_results['bsst_err'] + widget.itt_results['itt_err'] < 3){
  //     if (widget.bsst_results['bsst_err'] + widget.bsst_results['bsst_misses'] <= 2) {
  //       return true;
  //     }
  //   }
  //   else{
  //     return false;
  //   }
  // }

  // List<List<Object>> processData() {
  //   widget.dsst_results;
  //   widget.bsst_results;
  //   widget.itt_results;
  //   //print(widget.dsst_results);
  //   //print(widget.bsst_results);
  //   //print(widget.itt_results);
  //
  //   int sum = 0;
  //   widget.dsst_results['dsst_arr'].forEach((e) => sum += e);
  //   double dsst_mean = num.parse((sum/widget.dsst_results['dsst_levels']).toStringAsFixed(2));
  //
  //   sum = 0;
  //   for(int i = 0; i < widget.bsst_results['bsst_levels']; i++){
  //     if(widget.bsst_results['bsst_arr'][i] != -1)
  //     {
  //       sum += widget.bsst_results['bsst_arr'][i];
  //     }
  //   }
  //   double bsst_mean = num.parse((sum/(widget.bsst_results['bsst_levels'] - widget.bsst_results['bsst_misses'])).toStringAsFixed(2));
  //
  //   sum = 0;
  //   widget.itt_results['itt_arr'].forEach((e) => sum += e);
  //   double itt_mean = num.parse((sum/widget.itt_results['itt_levels']).toStringAsFixed(2));
  //
  //   List<List<Object>> data = [
  //     ['DSST_MEAN', 'DSST_ERRORS',  'BSST_MEAN',    'BSST_ERRORS',  'BSST_MISSES',     'ITT_MEAN',     'ITT_ERRORS'],
  //     [   dsst_mean,
  //         widget.dsst_results['dsst_err'],
  //         bsst_mean,
  //         widget.bsst_results['bsst_err'],
  //         widget.bsst_results['bsst_misses'],
  //         itt_mean,
  //         widget.itt_results['itt_err'],
  //     ]
  //   ];
  //
  //   //print(data);
  //
  //   return data;
  //
  // }

  @override
  void initState() {

    Timer timer;
    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      //print('Percent Update');
      if (this.mounted) {

      }
      else{
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    //processData();
    final firebaseUser = context.watch<User>();

    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Color(0xfface2d3),
        body: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<int>(
                future: PredictState(firebaseUser,
                  dsst_results: widget.dsst_results,
                    bsst_results: widget.bsst_results,
                    itt_results: widget.itt_results
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        //to do first time always sober
                        if (snapshot.data == 1)...[
                          Text(
                            'Test Passed!! \t Your car has been unlocked',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ]
                        else ...[
                          Text(
                            'Test Failed!! \t Your car will remain locked.',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ],
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            width: 180,
                            height: 60,
                            child: RaisedButton(
                              child: Text("Continue"),
                              disabledColor: Color(0xff00a86b).withAlpha(175),
                              disabledTextColor: Colors.white,
                              textColor: Colors.white,
                              color: Color(0xff00a86b).withAlpha(255),
                              splashColor: Color(0xfface2d3),
                              onPressed: () {
                                Navigator.popUntil(context, ModalRoute.withName('/'));
                              },
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120) //and back to the origin, could not be necessary #1
      ..close();
  }

  Future<bool> _onBackPressed() {

  }
}