import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/excel_generator.dart';
// import 'package:open_file/open_file.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crear archivo Excel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear archivo Excel'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            // crearArchivoExcel();
            // copyExcelFileToDownloads();
            // checkPermission();
            // descargarArchivoTexto();
            final file = await ExcelGenerator.resumenXsl();
            if(file == null)return ;
            // await OpenFilex.open(file.path);
            // final result = await OpenFile.open(path);

          },
          child: Text('Crear archivo Excel'),
        ),
      ),
    );
  }
}



void crearArchivoExcel() async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    final directorio = await getTemporaryDirectory();
    final rutaArchivo = '${directorio.path}/archivo_excel.xlsx';
    // final libro = Excel.createExcel();
    // libro.setDefaultSheet("Hoja1");
    // libro.save(fileName: rutaArchivo);
  } else {
    print('Permission denied');
  }
}


Future<bool> _requestPermission(Permission permission) async {
  AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
  if (build.version.sdkInt >= 30) {
    var result = await Permission.manageExternalStorage.request();
    return result.isGranted;
  } else {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result.isGranted;
    }
  }
}

void checkPermission() async {
  if (await _requestPermission(Permission.storage) == true) {
    print("Permission is granted");
  } else {
    print("permission is not granted");
  }
}

//------------------------------------

Future<void> copyExcelFileToDownloads() async {
  final status = await Permission.storage.request();
  if (!status.isGranted) return;

  final archivoTemporal = await crearArchivoExcelTemporal();

  if (archivoTemporal.existsSync()) {
    // Directorio de descargas en Android
    final downloadsDirectory = await getDownloadsDirectory();
    if (downloadsDirectory != null) {
      final destinationFilePath =
          '${downloadsDirectory.path}/archivo_excel.xlsx';

      try {
        // Copiar el archivo temporal al directorio de descargas
        archivoTemporal.copySync(destinationFilePath);
        print('Archivo copiado a: $destinationFilePath');
      } catch (e) {
        print('Error al copiar el archivo: $e');
      }
    } else {
      print(
          'El directorio de descargas no está disponible en este dispositivo.');
    }
  } else {
    print('El archivo temporal no existe.');
  }
}

Future<File> crearArchivoExcelTemporal() async {
  final directorio = await getTemporaryDirectory();
  final rutaArchivo = '${directorio.path}/archivo_excel.xlsx';
  // final libro = Excel.createExcel();
  // libro.setDefaultSheet("Hoja1");
  // libro.save(fileName: rutaArchivo);

  final archivo = File(rutaArchivo);
  final directorioExiste = await directorio.exists();
  final archivoExiste = await archivo.exists();

  print('El directorio temporal existe: $directorioExiste');
  print('El archivo temporal existe: $archivoExiste');

  return archivo;
}

//------------------------------------

Future<void> crearArchivoTexto() async {
  final directorio = await getTemporaryDirectory();
  final rutaArchivo = '${directorio.path}/archivo_texto.txt';

  final archivo = File(rutaArchivo);
  await archivo
      .writeAsString('¡Hola, mundo! Este es un archivo de texto simple.');

  print('Archivo de texto creado: $rutaArchivo');
}

Future<bool> crearArchivoTextoDownload() async {
  final downloadsDirectory = await getDownloadsDirectory();
  if (downloadsDirectory != null) {
    final rutaArchivo = '${downloadsDirectory.path}/archivo_texto.txt';

    final archivo = File(rutaArchivo);
    await archivo.writeAsString('¡Hola, mundo!.');

    print('Archivo de texto creado: $rutaArchivo');
    return true;
  } else {
    print('El directorio de descargas no está disponible en este dispositivo.');
    return false;
  }
}

void descargarArchivoTexto() async {
  final resp = await crearArchivoTextoDownload();
  if (!resp) return;
  final directorio = await getDownloadsDirectory();
  final rutaArchivo = '${directorio!.path}/archivo_texto.txt';
  final archivo = File(rutaArchivo);
  if (await archivo.exists()) {
    print('Archivo de texto descargado: $rutaArchivo');
  } else {
    print('El archivo de texto no existe.');
  }
}

void abrirFile(String path) async {
  // final result = await OpenFile.open(path);
  // if (result.type == ResultType.done) {
  //   print('El archivo se ha abierto correctamente.');
  // } else {
  //   print('No se pudo abrir el archivo.');
  // }
}

// Future<void> copyFileToDownloads(File sourceFile) async {
//     try {
//       final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
//       final destinationFile = File('${downloadsDirectory.path}/${sourceFile.uri.pathSegments.last}');

//       await sourceFile.copy(destinationFile.path);
//       print('Archivo copiado a la carpeta de descargas: ${destinationFile.path}');
//     } catch (e) {
//       print('Error al copiar el archivo a descargas: $e');
//     }
//   }