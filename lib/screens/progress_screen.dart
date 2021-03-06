import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:myapp_3dapp/services/database_service.dart';
import 'package:myapp_3dapp/services/excel_service.dart';

class CustomProgressIndicator extends StatefulWidget {

  final Map dsst_results;
  final Map bsst_results;
  final Map itt_results;

  CustomProgressIndicator({this.dsst_results, this.bsst_results, this.itt_results});

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  double _height;
  double _width;

  double percent = 0.0;

  bool proceed = false;

  bool creating_excel = false;

  bool created_excel = false;

  ExcelServices es = new ExcelServices();

  DatabaseService ds = new DatabaseService();

  Future<String> CreateCSV() async {
    return await es.CreateCSV(widget.dsst_results, widget.bsst_results, widget.itt_results);
  }

  deleteFile() async {
    return await es.DeleteCSV();
  }

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
              Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: LiquidCircularProgressIndicator(
                      value: percent / 100,
                      // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(Color(0xff00a86b).withAlpha(175)),
                      backgroundColor: Colors.white,
                      borderColor: Colors.white,
                      borderWidth: 4.0,
                      direction: Axis.vertical,
                      center: Text(
                        percent.toString() + "%",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Successfully completed the test!! \n \t \t your car has been unlocked',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SizedBox(
                      width: 180,
                      height: 60,
                    child: FutureBuilder<dynamic>(
                    future: CreateCSV(), // a previously-obtained Future<String> or null
                    builder: (context, snapshot) {
                      List<Widget> children;
                      if (snapshot.data == "Excel Created") {
                        //print("Created");
                        return FutureBuilder<dynamic>(
                            future: ds.UploadCSV(),
                            // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                              List<Widget> children;
                              if (snapshot.data == "Excel Uploaded") {
                                //print("Uploaded");
                                deleteFile();
                                return RaisedButton(
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
                                );
                              }
                              return SizedBox.shrink();
                            }
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                      ),
                    ),
                  ),
                ],
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