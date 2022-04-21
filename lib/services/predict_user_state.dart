import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:path_provider/path_provider.dart';

void PredictState() async {

  // final fileName = 'diabetes_classifier.json';
  // final file = File(fileName);
  final encodedModel = await rootBundle.loadString('assets/intoxication_classifier.json');
  final classifier = LogisticRegressor.fromJson(encodedModel);

  final unlabelledData = await fromCsv('some_unlabelled_data.csv');
  final prediction = classifier.predict(unlabelledData);

  print(prediction.header); // ('class variable (0 or 1)')
  print(prediction.rows);
}