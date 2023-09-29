import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'nav_helper.dart';

void main() {
  runApp(const MyApp());
  // Add import
  // import 'package:data_table_2/data_table_2.dart';
  // and uncomment below line to remove widgets' logs
  //dataTableShowLogs = false;
}

const String initialRoute = '/paginated2';

Scaffold _getScaffold(BuildContext context, Widget body,
    [List<String>? options]) {
  var defaultOption = getCurrentRouteOption(context);
  if (defaultOption.isEmpty && options != null && options.isNotEmpty) {
    defaultOption = options[0];
  }
  return Scaffold(
    body: body,
  );
}

String _getCurrentRoute(BuildContext context) {
  return ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.name != null
      ? ModalRoute.of(context)!.settings.name!
      : initialRoute;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'main',
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[300],
      ),
      initialRoute: initialRoute,
      routes: {
        '/paginated2': (context) => _getScaffold(context,
            const PaginatedDataTable2Demo(), getOptionsForRoute('/paginated2')),
      },
    );
  }
}

class PaginatedDataTable2Demo extends StatefulWidget {
  const PaginatedDataTable2Demo({super.key});

  @override
  PaginatedDataTable2DemoState createState() => PaginatedDataTable2DemoState();
}

class PaginatedDataTable2DemoState extends State<PaginatedDataTable2Demo> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DataColumn> get _columns {
    return [
      const DataColumn(
        label: Text('Desert'),
        // onSort: (columnIndex, ascending) =>
        //     sort<String>((d) => d.name, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Calories'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.calories, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Fat (gm)'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.fat, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Carbs (gm)'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.carbs, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Protein (gm)'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.protein, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Sodium (mg)'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.sodium, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Calcium (%)'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.calcium, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Iron (%)'),
        numeric: true,
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.iron, columnIndex, ascending),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      columns: _columns,
      source: DessertDataSource(false),
    );
  }
}

class DessertDataSource extends DataTableSource {


  DessertDataSource(
      [sortedByCalories = false,
      this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]) {
    desserts = _desserts;
    // desserts = [_desserts[0]];
    if (sortedByCalories) {
      sort((d) => d.calories, true);
    }
  }

  late List<Dessert> desserts;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(Dessert d) getField, bool ascending) {
    desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= desserts.length) throw 'index > _desserts.length';
    final dessert = desserts[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(Text(dessert.name)),
        DataCell(Text('${dessert.calories}')),
        DataCell(Text(dessert.fat.toStringAsFixed(1))),
        DataCell(Text('${dessert.carbs}')),
        DataCell(Text(dessert.protein.toStringAsFixed(1))),
        DataCell(Text('${dessert.sodium}')),
        DataCell(Text(format.format(dessert.calcium / 100))),
        DataCell(Text(format.format(dessert.iron / 100))),
      ],
    );
  }

  @override
  int get rowCount => desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

int _idCounter = 0;

class Dessert {
  Dessert(
    this.name,
    this.calories,
    this.fat,
    this.carbs,
    this.protein,
    this.sodium,
    this.calcium,
    this.iron,
  );

  final int id = _idCounter++;
  // final int id = 1;

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;
  bool selected = false;
}

List<Dessert> _desserts = <Dessert>[
  Dessert(
    'Frozen Yogurt',
    159,
    6.0,
    24,
    4.0,
    87,
    14,
    1,
  ),
  Dessert(
    'Ice Cream Sandwich',
    237,
    9.0,
    37,
    4.3,
    129,
    8,
    1,
  ),
  Dessert(
    'Eclair',
    262,
    16.0,
    24,
    6.0,
    337,
    6,
    7,
  ),
  Dessert(
    'Cupcake',
    305,
    3.7,
    67,
    4.3,
    413,
    3,
    8,
  ),
  Dessert(
    'Gingerbread',
    356,
    16.0,
    49,
    3.9,
    327,
    7,
    16,
  ),
  Dessert(
    'Jelly Bean',
    375,
    0.0,
    94,
    0.0,
    50,
    0,
    0,
  ),
  Dessert(
    'Lollipop',
    392,
    0.2,
    98,
    0.0,
    38,
    0,
    2,
  ),
  Dessert(
    'Honeycomb',
    408,
    3.2,
    87,
    6.5,
    562,
    0,
    45,
  ),
  Dessert(
    'Donut',
    452,
    25.0,
    51,
    4.9,
    326,
    2,
    22,
  ),
  Dessert(
    'Apple Pie',
    518,
    26.0,
    65,
    7.0,
    54,
    12,
    6,
  ),
  Dessert(
    'Frozen Yougurt with sugar',
    168,
    6.0,
    26,
    4.0,
    87,
    14,
    1,
  ),
  Dessert(
    'Ice Cream Sandich with sugar',
    246,
    9.0,
    39,
    4.3,
    129,
    8,
    1,
  ),
  Dessert(
    'Eclair with sugar',
    271,
    16.0,
    26,
    6.0,
    337,
    6,
    7,
  ),
  Dessert(
    'Cupcake with sugar',
    314,
    3.7,
    69,
    4.3,
    413,
    3,
    8,
  ),
  Dessert(
    'Gingerbread with sugar',
    345,
    16.0,
    51,
    3.9,
    327,
    7,
    16,
  ),
  Dessert(
    'Jelly Bean with sugar',
    364,
    0.0,
    96,
    0.0,
    50,
    0,
    0,
  ),
  Dessert(
    'Lollipop with sugar',
    401,
    0.2,
    100,
    0.0,
    38,
    0,
    2,
  ),
  Dessert(
    'Honeycomd with sugar',
    417,
    3.2,
    89,
    6.5,
    562,
    0,
    45,
  ),
  Dessert(
    'Donut with sugar',
    461,
    25.0,
    53,
    4.9,
    326,
    2,
    22,
  ),
  Dessert(
    'Apple pie with sugar',
    527,
    26.0,
    67,
    7.0,
    54,
    12,
    6,
  ),
  Dessert(
    'Forzen yougurt with honey',
    223,
    6.0,
    36,
    4.0,
    87,
    14,
    1,
  ),
  Dessert(
    'Ice Cream Sandwich with honey',
    301,
    9.0,
    49,
    4.3,
    129,
    8,
    1,
  ),
  Dessert(
    'Eclair with honey',
    326,
    16.0,
    36,
    6.0,
    337,
    6,
    7,
  ),
  Dessert(
    'Cupcake with honey',
    369,
    3.7,
    79,
    4.3,
    413,
    3,
    8,
  ),
  Dessert(
    'Gignerbread with hone',
    420,
    16.0,
    61,
    3.9,
    327,
    7,
    16,
  ),
  Dessert(
    'Jelly Bean with honey',
    439,
    0.0,
    106,
    0.0,
    50,
    0,
    0,
  ),
  Dessert(
    'Lollipop with honey',
    456,
    0.2,
    110,
    0.0,
    38,
    0,
    2,
  ),
  Dessert(
    'Honeycomd with honey',
    472,
    3.2,
    99,
    6.5,
    562,
    0,
    45,
  ),
  Dessert(
    'Donut with honey',
    516,
    25.0,
    63,
    4.9,
    326,
    2,
    22,
  ),
  Dessert(
    'Apple pie with honey',
    582,
    26.0,
    77,
    7.0,
    54,
    12,
    6,
  ),
];
