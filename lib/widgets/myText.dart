import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String texto;
  double tamano;
  Color color;
  FontWeight fontWeight;

  MyText(
    this.texto, {
    this.tamano = 18.0,
    this.color = Colors.deepPurple,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        style:
            TextStyle(color: color, fontSize: tamano, fontWeight: fontWeight));
  }
}
