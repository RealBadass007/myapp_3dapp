import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExcelServices{
  static void CreateCSV(List userReactArr, int errors) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Testing'];

    sheet.appendRow(["ID", "ITT1", "ITT2", "ITT3", "Errors"]);

    sheet.appendRow(["TEMP_ID", "${userReactArr[0]}", "${userReactArr[1]}", "${userReactArr[2]}", "${errors}"]);

    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true)
// The created directory is returned as a Future.
        .then((Directory directory) {
      print('Path of New Dir: '+ directory.path);
      excel.encode().then((onValue) {
        File(join("${directory.path}/excel/TempName.xlsx"))
          ..createSync(recursive: true)
          ..writeAsBytesSync(onValue);
      });
    });


  }
}