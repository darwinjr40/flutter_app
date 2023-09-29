//  List<DataRow> getRows(List<SkuSearch> skpList) {
//     return List<DataRow>.generate(
//         100,
//         (index) => DataRow(cells: [
//               DataCell(SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         title: const Text(
//                             'Título fsdjkfhskdjfdskjfskfhdskjfshdfkjsdhfjksfkdssdh3856324785632478563285634785362853465324532532534523453252345'),
//                         subtitle: const Text('123456789'),
//                         onTap: () {},
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(' id corto:'),
//                           Text('vencimiento:'),
//                         ],
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('123456789'),
//                           Text('16/08/2013'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//               DataCell(Center(
//                 child: Text(((index + 0.1) * 25.4).toString()),
//               )),
//               DataCell(Center(
//                 child: Text(((index + 0.1) * 25.4).toString()),
//               )),
//               DataCell(
//                 Center(
//                   child: InkWell(
//                       onTap: () {
//                         debugPrint('nise');
//                       },
//                       child: Text('A' * (10 - index % 10))),
//                 ),
//               ),
//             ]));
//   }