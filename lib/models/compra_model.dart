import 'dart:convert';
import 'dart:math';

class Compra {
  DateTime? fecha;
  String? proveedor;
  int? cantidad;
  int? costo;
  int? descuento;
  int? total;

  Compra({
    this.fecha,
    this.proveedor,
    this.cantidad,
    this.costo,
    this.descuento,
    this.total,
  });

  Compra copyWith({
    DateTime? fecha,
    String? proveedor,
    int? cantidad,
    int? costo,
    int? descuento,
    int? total,
  }) =>
      Compra(
        fecha: fecha ?? this.fecha,
        proveedor: proveedor ?? this.proveedor,
        cantidad: cantidad ?? this.cantidad,
        costo: costo ?? this.costo,
        descuento: descuento ?? this.descuento,
        total: total ?? this.total,
      );

  factory Compra.fromRawJson(String str) => Compra.fromJson(json.decode(str));

  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        proveedor: json["proveedor"],
        cantidad: json["cantidad"],
        costo: json["costo"],
        descuento: json["descuento"],
        total: json["total"],
      );

  factory Compra.random() {
    final random = Random();
    return Compra(
      fecha: DateTime.now().subtract(Duration(days: random.nextInt(30))),
      proveedor: 'Proveedor ${random.nextInt(10)}',
      cantidad: random.nextInt(100),
      costo: random.nextInt(1000),
      descuento: random.nextInt(100),
      total: random.nextInt(1000),
    );
  }

  String toRawJson() => json.encode(toJson());

  static List<Compra> getListOfRandomCompras(int count) {
    return List.generate(count, (_) => Compra.random());
  }




  Map<String, dynamic> toJson() => {
        "fecha": fecha?.toString(),
        "proveedor": proveedor,
        "cantidad": cantidad,
        "costo": costo,
        "descuento": descuento,
        "total": total,
  };
 
  static List<String> dataColumns(List<Compra> compras){
     return (compras.isEmpty)
        ? List<String>.empty()
        : compras.first.toJson().keys.toList();
  }

  static List<Map<String, dynamic>> dataRow(List<Compra> compras) {
    return compras.map(
      (element) => element.toJson()
    ).toList();
  }
}
