import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:path_provider/path_provider.dart';

void CreateModel() async {
  final rawCsvContent = await rootBundle.loadString('assets/datasets/intoxication_data.csv');
  final samples = DataFrame.fromRawCsv(rawCsvContent);
  final targetColumnName = 'RESULT';
  final splits = splitData(samples, [0.87]);
  final validationData = splits[0];
  final testData = splits[1];
  final validator = CrossValidator.kFold(validationData, numberOfFolds: 8);
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

  final testSplits = splitData(testData, [0.8]);
  final classifier = createClassifier(testSplits[0]);
  final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);

  //print(finalScore.toStringAsFixed(2));

  final appDocDir = await getApplicationDocumentsDirectory();
  print(appDocDir.path + 'diabetes_classifier.json');
  await classifier.saveAsJson('/storage/emulated/0/Download/' + 'intoxication_classifier.json');
}