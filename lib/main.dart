import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hola, mundo'),
        ),
        body: Center(
          child: Text('¡Hola, mundo!'),
        ),
      ),
    ),
  );
}
