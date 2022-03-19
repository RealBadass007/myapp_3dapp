import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';

class ExcelServices{

  Future<String> CreateCSV(List userReactArr, int errors) async {

    final excel = Excel.createExcel();

    excel.rename('Sheet1', 'TestData');

    Sheet sheet = excel['TestData'];

    sheet.appendRow(["ID", "ITT1", "ITT2", "ITT3", "Errors"]);

    sheet.appendRow(["TEMP_ID", "${userReactArr[0]}", "${userReactArr[1]}", "${userReactArr[2]}", "${errors}"]);

    // final PermissionHandler _permissionHandler = PermissionHandler();
    // var result = await _permissionHandler.requestPermissions([PermissionGroup.contacts]);

    print("create sheet: ${sheet.rows}");

    await excel.encode().then((onValue) {
      File(join("/storage/emulated/0/Download/Testing.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });

    return "Excel Created";

    // Directory appDocDirectory = await getApplicationDocumentsDirectory();

//     new Directory(appDocDirectory.path).create(recursive: true)
// // The created directory is returned as a Future.
//         .then((Directory directory) {
//       print('Path of New Dir: '+ directory.path);
//
//     });
  }

  static void DeleteCSV() async {

}

}