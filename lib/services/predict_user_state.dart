import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:myapp_3dapp/services/create_model.dart';
import 'package:path_provider/path_provider.dart';

import 'database_service.dart';

List<List<Object>> processData(Map dsst_results, Map bsst_results, Map itt_results) {
  dsst_results;
  bsst_results;
  itt_results;
  //print(widget.dsst_results);
  //print(widget.bsst_results);
  //print(widget.itt_results);

  int sum = 0;
  dsst_results['dsst_arr'].forEach((e) => sum += e);
  double dsst_mean = num.parse((sum/dsst_results['dsst_levels']).toStringAsFixed(2));

  sum = 0;
  for(int i = 0; i < bsst_results['bsst_levels']; i++){
    if(bsst_results['bsst_arr'][i] != -1)
    {
      sum += bsst_results['bsst_arr'][i];
    }
  }
  double bsst_mean = num.parse((sum/(bsst_results['bsst_levels'] - bsst_results['bsst_misses'])).toStringAsFixed(2));

  sum = 0;
  itt_results['itt_arr'].forEach((e) => sum += e);
  double itt_mean = num.parse((sum/itt_results['itt_levels']).toStringAsFixed(2));

  List<List<Object>> data = [
    ['DSST_MEAN',     'DSST_ERRORS',              'BSST_MEAN',     'BSST_ERRORS',               'BSST_MISSES',                   'ITT_MEAN',      'ITT_ERRORS'         ],
    [   dsst_mean,    dsst_results['dsst_err'],    bsst_mean,       bsst_results['bsst_err'],    bsst_results['bsst_misses'],     itt_mean,     itt_results['itt_err'] ]
  ];

  //print(data);

  return data;

}

bool AcceptableErrNMissCount(int dsst_err, int bsst_err, int bsst_misses, int itt_err) {

  if (dsst_err + bsst_err + itt_err < 3){
    if (bsst_err + bsst_misses <= 2) {
      return true;
    }
  }
  else{
    return false;
  }
}

Future<int> PredictState(User firebaseUser, {Map dsst_results = null, Map bsst_results = null, Map itt_results = null}) async {

  //List<List<Object>> data

  DatabaseService dbs = new DatabaseService();
  List<List<Object>> data;

  if(dsst_results != null){
    data = processData(dsst_results, bsst_results, itt_results);
  }

  int final_result = 0;
  final fileName = 'intoxication_classifier.json';
  final file = File('/storage/emulated/0/Android/data/com.example.myapp_3dapp/files/' + fileName);
  final encodedModel = await file.readAsString();
  final classifier = LogisticRegressor.fromJson(encodedModel);

  // data = [
  //   ['DSST_MEAN', 'DSST_ERRORS',  'BSST_MEAN',    'BSST_ERRORS',  'BSST_MISSES',     'ITT_MEAN',     'ITT_ERRORS'],
  //   // [   2426.4,	        2,	          539.2,	          1,	            1,	            811.25,		          1    ],
  //   // [   1903.2,	        0,	          504.2,	          0,	            1,	            807.25,		          0    ],
  //   // [   1700.4,	        0,	          510,	            0,	            0,	            500.25,		          0    ],
  //   // [   2047.8,	        0,	          480,	            0,	            0,	            480.5,		          0    ],
  // ];

  print(data);

  final unlabelledData = DataFrame(data);

  final prediction = classifier.predict(unlabelledData);

  print(prediction.header); // ('class variable (0 or 1)')
  //print(prediction.rows);

  int prediction_result = num.parse((prediction.rows.first.first).toStringAsFixed(0));
  print("prediction_result - ${prediction_result}");

  //if(prediction_result == 1 && AcceptableErrNMissCount(dsst_results, bsst_results, itt_results)){
  if(prediction_result == 1 && AcceptableErrNMissCount(data[1][1], data[1][3], data[1][4], data[1][6])){
    final_result = 1;
    dbs.updateTestDate(user_uid: firebaseUser.uid, test_result: "Pass");
  }
  else{
    final_result = 0;
    dbs.updateTestDate(user_uid: firebaseUser.uid, test_result: "Fail");
  }

  print("final_result - ${final_result}");

  return final_result;
}