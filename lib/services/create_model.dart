import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:path_provider/path_provider.dart';


void CreateModel() async {
  final rawCsvContent = await rootBundle.loadString('assets/datasets/intoxication_data.csv');
  final samples = DataFrame.fromRawCsv(rawCsvContent);
  final targetColumnName = 'RESULT';
  final splits = splitData(samples, [0.7]);
  final validationData = splits[0];
  final testData = splits[1];
  final validator = CrossValidator.kFold(validationData, numberOfFolds: 9);
  final createClassifier = (DataFrame samples) =>
      LogisticRegressor(
        samples,
        targetColumnName,
        optimizerType: LinearOptimizerType.gradient,
        iterationsLimit: 90,
        learningRateType: LearningRateType.decreasingAdaptive,
        batchSize: samples.rows.length,
        probabilityThreshold: 0.7,
      );
  final scores = await validator.evaluate(createClassifier, MetricType.accuracy);
  final accuracy = scores.mean();

  print('Creating Model...');
  print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');

  final testSplits = splitData(testData, [0.7]);
  final classifier = createClassifier(testSplits[0]);
  final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);

  print(finalScore.toStringAsFixed(2));

  final appDocDir = await getApplicationDocumentsDirectory();
  //print(appDocDir.path + 'diabetes_classifier.json');
  await classifier.saveAsJson('/storage/emulated/0/Android/data/com.example.myapp_3dapp/files/' + 'intoxication_classifier.json');

  //2226.4	485.9092508	0	509.2	54.87895772	0	1	481.25	78.31719692	0
  //1903.2	0	504.2	0	1	807.25	0
  //2688.4	0	460	0	0	611.75	1
  //2747.8	4	561	1	4	890.5	3


  //final unlabelledData = await fromCsv('/storage/emulated/0/Download/' + 'unlabelled_data.csv');

  //DSST_MEAN	DSST_ERRORS	BSST_MEAN	BSST_ERRORS	BSST_MISSES	ITT_MEAN	ITT_ERRORS

  final data = [
    ['DSST_MEAN', 'DSST_ERRORS',  'BSST_MEAN',    'BSST_ERRORS',  'BSST_MISSES',     'ITT_MEAN',     'ITT_ERRORS'],
    [   2426.4,	        2,	          539.2,	          1,	            1,	            811.25,		          1    ],
    [   1903.2,	        0,	          504.2,	          0,	            1,	            807.25,		          0    ],
    [   1700.4,	        0,	          510,	            0,	            0,	            500.25,		          0    ],
    [   1393  ,	        0,	          460,	            0,	            0,	            492.5,		          0    ],
  ];

  final unlabelledData = DataFrame(data);

  final prediction = classifier.predict(unlabelledData);

  print(prediction.header); // ('class variable (0 or 1)')
  print(prediction.rows);

  //to do : download model from firebase

}

