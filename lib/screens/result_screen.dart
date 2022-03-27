import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:myapp_3dapp/services/database_service.dart';
import 'package:myapp_3dapp/services/excel_service.dart';

class ResultProgressIndicator extends StatefulWidget {
  final Map dsst_results;
  final Map bsst_results;
  final Map itt_results;
  final String user_status;

  ResultProgressIndicator(
      {this.dsst_results,
      this.bsst_results,
      this.itt_results,
      this.user_status});

  @override
  _ResultProgressIndicatorState createState() =>
      _ResultProgressIndicatorState();
}

class _ResultProgressIndicatorState extends State<ResultProgressIndicator> {
  double _height;
  double _width;

  double percent = 0.0;

  bool proceed = false;

  bool creating_excel = false;

  bool created_excel = false;

  ExcelServices es = new ExcelServices();

  DatabaseService ds = new DatabaseService();

  Future<String> CreateCSV() async {
    return await es.CreateCSV(widget.dsst_results, widget.bsst_results,
        widget.itt_results, widget.user_status);
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
      } else {
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
                  Center(
                    child: SizedBox(
                      width: 180,
                      height: 80,
                      child: FutureBuilder<dynamic>(
                          future:
                              CreateCSV(), // a previously-obtained Future<String> or null
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
                                        disabledColor:
                                            Color(0xff00a86b).withAlpha(175),
                                        disabledTextColor: Colors.white,
                                        textColor: Colors.white,
                                        color: Color(0xff00a86b).withAlpha(255),
                                        splashColor: Color(0xfface2d3),
                                        onPressed: () {
                                          Navigator.popUntil(context,
                                              ModalRoute.withName('/'));
                                        },
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      );
                                    }
                                    return Column(
                                      children: <Widget> [
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text('Awaiting result...'),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return SizedBox.shrink();
                            }
                          }),
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

  Future<bool> _onBackPressed() {}
}
