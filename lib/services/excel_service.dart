import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class ExcelServices {

  List generateIttData(Map itt_results) {

    List temp_itt_arr = [];
    List unpacked_itt_arr = itt_results["itt_arr"];

    //print("unpacked_itt_arr : ${unpacked_itt_arr}");

    for (int i = 0; i < itt_results["itt_levels"]; i++) {
      temp_itt_arr.add("${unpacked_itt_arr[i]}");
    }
    temp_itt_arr.add("${itt_results["itt_err"]}");
    //print("temp_itt_arr: ${temp_itt_arr}");
    return temp_itt_arr;
  }

  List generateBsstData(Map bsst_results) {

    List temp_bsst_arr = [];
    List unpacked_bsst_arr = bsst_results["bsst_arr"];

    //print("unpacked_bsst_arr : ${unpacked_bsst_arr}");

    for (int i = 0; i < bsst_results["bsst_levels"]; i++) {
      temp_bsst_arr.add("${unpacked_bsst_arr[i]}");
    }
    temp_bsst_arr.add("${bsst_results["bsst_err"]}");
    temp_bsst_arr.add("${bsst_results["bsst_misses"]}");
    //print("temp_bsst_arr: ${temp_bsst_arr}");
    return temp_bsst_arr;
  }

  List generateDsstData(Map dsst_results) {

    List temp_dsst_arr = [];
    List unpacked_dsst_arr = dsst_results["dsst_arr"];

    //print("unpacked_dsst_arr : ${unpacked_dsst_arr}");

    for (int i = 0; i < dsst_results["dsst_levels"]; i++) {
      temp_dsst_arr.add("${unpacked_dsst_arr[i]}");
    }
    temp_dsst_arr.add("${dsst_results["dsst_err"]}");
    //print("temp_dsst_arr: ${temp_dsst_arr}");
    return temp_dsst_arr;
  }

  Future<String> CreateCSV(

    Map dsst_results,
    Map bsst_results,
    Map itt_results,

  ) async {
    final excel = Excel.createExcel();

    excel.rename('Sheet1', 'TestData');

    Sheet sheet = excel['TestData'];
    //sheet.appendRow(["ID", "BSST1", "BSST2", "BSST3", "BSST4", "BSST5", "BSST_ERRORS", "BSST_MISSES", "ITT1", "ITT2", "ITT3", "ITT4", "ITT_ERRORS"]);

    List temp_dsst_arr = generateDsstData(dsst_results);
    List temp_bsst_arr = generateBsstData(bsst_results);
    List temp_itt_arr = generateIttData(itt_results);


    print("After generate Function CSV");

    List final_arr = ["TEMP_ID", ...temp_dsst_arr,...temp_bsst_arr, ...temp_itt_arr];

    sheet.appendRow(final_arr);

    //sheet.appendRow(["TEMP_ID", "${userReactArr[0]}", "${userReactArr[1]}", "${userReactArr[2]}", "${userReactArr[3]}", "${errors}"]);

    // final PermissionHandler _permissionHandler = PermissionHandler();
    // var result = await _permissionHandler.requestPermissions([PermissionGroup.contacts]);

    print("create sheet: ${sheet.rows}");

    await excel.encode().then((onValue) {
      File(join("/storage/emulated/0/Download/5D_App_Testing.xlsx"))
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

  DeleteCSV() async {
    final file = await File("/storage/emulated/0/Download/5D_App_Testing.xlsx");
    await file.delete();
  }
}
