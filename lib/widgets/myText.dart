import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String texto;
  final double tamano;
  final Color color;
  final FontWeight fontWeight;

  MyText(
    this.texto, {
    this.tamano = 18.0,
    this.color = Colors.deepPurple,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: tamano,
          fontWeight: fontWeight,
        ));
  }
}
