import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataTableDemo(),
    );
  }
}

class Model{
  final int key;
  final String value;

  Model({required this.key, required this.value});
}

class DataTableDemo extends StatelessWidget {
  final List<String> columns = [
    'ID',
    'Name',
    'Age',
    'Age1',
    'Age2',
    'Age3',
    'Age4',
    'Age5',
    'Age6',
  ];

  final List<Map<String, dynamic>> data = [
    {
      'id': 1,
      'name': 'John',
      'age': 30,
      'age1': 31,
      'age2': 32,
      'age3': 33,
      'age4': 34,
      'age5': 35,
    },
  ];

  DataTableDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Compra> compras = Compra.getListOfRandomCompras(1000);    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Generic DataTable'),
        ),
        body: GenericDataTable(columns: Compra.dataColumns(compras), data: Compra.dataRow(compras)));
  }
}

class GenericDataTable extends StatelessWidget {
  const GenericDataTable({
    super.key,
    required this.columns,
    required this.data,
  });

  final List<String> columns;
  final List<Map<String, dynamic>> data;

  List<DataColumn> buildDataColumns(List<String> columns) {
    if (columns.isEmpty) {
      return [
        const DataColumn( 
        label: Expanded(
          child: Text(
            'No Hay Datos',
            textAlign: TextAlign.center,
          ),
        ),
      )
      ];
    }
    return columns.map<DataColumn>(
      (column) => DataColumn( 
        label: Expanded(
          child: Text(
            column,
            textAlign: TextAlign.center,
          ),
        ),
      )
    ).toList();
  }

  List<DataRow> buildDataRows(List<Map<String, dynamic>> data, List<String> columns) {
    return data.map<DataRow>((rowData) {
      return DataRow( 
        cells: columns.map<DataCell>(
          (column) => DataCell(Center(child: Text('${rowData[column]}')))
        ).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: buildDataColumns(columns),
            rows: buildDataRows(data, columns),
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return const Color.fromARGB(255, 51, 10, 201);
            }),
            border: TableBorder.all(),
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            dataRowMinHeight: 25,
            dataRowMaxHeight: 30,
            columnSpacing: 15,
            headingRowHeight: 30,
            horizontalMargin: 10,
          ),
        ),
      ),
    );
  }
}
