import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelGenerator {
  static const String folder = 'excel_generated';

  static String uniqueName() {
    var now = DateTime.now();
    var day = now.day.toString().padLeft(2, '0');
    var month = now.month.toString().padLeft(2, '0');
    var year = now.year.toString().padLeft(4, '0');
    var hour = now.hour.toString().padLeft(2, '0');
    var minute = now.minute.toString().padLeft(2, '0');
    var second = now.second.toString().padLeft(2, '0');
    return '$day$month$year$hour$minute$second';
  }

  static Future<File?> resumenXsl() async {
    final Workbook workbook = Workbook();

    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = true;
    sheet.name = "Resumen";

    Range cell;

    cell = sheet.getRangeByName('B3');
    cell.setText("Fecha Inicio");
    cell.cellStyle.fontSize = 10;
    cell.cellStyle.fontName = 'Arial';
    cell = sheet.getRangeByName('C3');
    cell.cellStyle.fontSize = 10;
    cell.cellStyle.fontName = 'Arial';

    cell = sheet.getRangeByName('B4');
    cell.setText("Fecha Final");
    cell.cellStyle.fontSize = 10;
    cell.cellStyle.fontName = 'Arial';

    Map<String, String> headers = {
      'B': 'Tipo de Pago',
      'C': 'Monto Bs',
    };
    CellStyle headRowCellStyle2 = CellStyle(workbook);
    headRowCellStyle2.bold = true;
    headRowCellStyle2.fontSize = 10;
    headRowCellStyle2.fontName = 'Arial';
    headRowCellStyle2.backColor = '#FFFF00';
    headRowCellStyle2.hAlign = HAlignType.left;

//* Formating Columns And Range

    Map<String, String> headers4 = {
      'A': 'Fecha',
      'B': 'Clientes',
      'C': 'Descuentos',
      'D': 'Total Bs',
    };

    List<String> dates4 = [];
    List<String> clientes4 = [];
    List<String> discounts4 = [];
    List<String> totals4 = [];

    Map<String, String> headers5 = {
      'A': 'Mes',
      'B': 'Clientes',
      'C': 'Descuentos',
      'D': 'Total Bs',
    };

    List<String> months5 = [];
    List<String> clientes5 = [];
    List<String> discounts5 = [];
    List<String> totals5 = [];

    CellStyle headRowCellStyle5 = CellStyle(workbook);

    int row5 = 1;

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    return await saveDocument('_${uniqueName()}', bytes);
  }

  static Future<File?> saveDocument(String name, List<int> bytes) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = join(dir.path, folder, '$name.xlsx');
      final file = await File(path).create(recursive: true);
      await file.writeAsBytes(bytes, flush: true, mode: FileMode.append);
      if (await file.exists()) {
        print('Archivo de excel descargado: $path');
      } else {
        print('El archivo de excel no existe.');
      }
      return file;
    } catch (e) {
      return null;
    }
  }

  static Future<File?> saveDocument1(String nameFile, List<int> bytes) async {
    try {
      final dir = await getDownloadsDirectory();
      if (dir == null) return null;
      final path = join(dir.path, '$nameFile.xlsx');

      final file = await File(path).create(recursive: true);
      await file.writeAsBytes(bytes, flush: true, mode: FileMode.write);
      if (await file.exists()) {
        print('Archivo de excel descargado: $path');        
      } else {
        print('El archivo de excel no existe.');
      }
      return file;
    } catch (e) {
      return null;
    }
  }

  // await downloadFile(file, join(dir.path, 'prueba.xlsx'));
  //       await file.delete();
  static Future<void> downloadFile(File file, String path) async {
    Dio dio = Dio();
    await dio.download(file.path, file.path);
  }
}
