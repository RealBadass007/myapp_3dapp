import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:myapp_3dapp/services/create_model.dart';
import 'package:path_provider/path_provider.dart';

Future<int> PredictState(List<List<Object>> data) async {

  final fileName = 'intoxication_classifier.json';
  final file = File('/storage/emulated/0/Android/data/com.example.myapp_3dapp/files/' + fileName);
  final encodedModel = await file.readAsString();
  final classifier = LogisticRegressor.fromJson(encodedModel);

  // data = [
  //   ['DSST_MEAN', 'DSST_ERRORS',  'BSST_MEAN',    'BSST_ERRORS',  'BSST_MISSES',     'ITT_MEAN',     'ITT_ERRORS'],
  //   [   2426.4,	        2,	          539.2,	          1,	            1,	            811.25,		          1    ],
  //   [   1903.2,	        0,	          504.2,	          0,	            1,	            807.25,		          0    ],
  //   [   1700.4,	        0,	          510,	            0,	            0,	            500.25,		          0    ],
  //   [   2047.8,	        0,	          480,	            0,	            0,	            480.5,		          0    ],
  // ];

  print(data);

  final unlabelledData = DataFrame(data);

  final prediction = classifier.predict(unlabelledData);

  print(prediction.header); // ('class variable (0 or 1)')
  //print(prediction.rows);

  int result = num.parse((prediction.rows.first.first).toStringAsFixed(0));
  print(result);

  return result;
}