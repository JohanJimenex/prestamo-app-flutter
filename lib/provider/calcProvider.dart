import 'dart:math';
 

import 'package:flutter/material.dart';

class CalcProvider extends ChangeNotifier {
  //paraformatear montos a dinero
  //agregar al pubspec.yaml  dependencie intl:
  //double f = NumberFormat.simpleCurrency();
  //f.format(montoPrestamo).toString();

  double _montoPrestamo = 0;
  double _tasaAnual = 0;
  double _cantidadMeses = 0;

  double cuotaMensual = 0;
  double saldoInicial = 0;
  double capital = 0;

  double montoTotal = 0;

  List<Map<String, double>> listaDatos = [];

  //Setters
  set montoPrestamo(double montoPrestamo) => _montoPrestamo = montoPrestamo;

  set tasaAnual(double tasaAnual) => _tasaAnual = tasaAnual / 12;

  set cantidadMeses(double cantidadMeses) => _cantidadMeses = cantidadMeses;

  void calcular() {
    //limpiampo lsita
    listaDatos = [];

    saldoInicial = _montoPrestamo;

    cuotaMensual = _montoPrestamo *
        ((pow((1.0 + _tasaAnual / 100.0), _cantidadMeses) *
                (_tasaAnual / 100.0)) /
            (pow((1.0 + _tasaAnual / 100.0), _cantidadMeses) - 1.0));
    montoTotal = cuotaMensual * _cantidadMeses;

    for (double i = 0; i < _cantidadMeses; i++) {
      //
      double interes = saldoInicial * _tasaAnual / 100;
      capital = cuotaMensual - interes;
      double balance = saldoInicial - capital;

      if (cuotaMensual.isNaN || capital.isNaN || balance.isNaN) {
        cuotaMensual = 0;
        interes = 0;
        capital = 0;
        balance = 0;
      }

      //lista
      listaDatos.add({
        "cuotaMensual": cuotaMensual,
        "interes": interes,
        "capital": capital,
        "balance": balance,
      });

      saldoInicial = saldoInicial - capital;
    }

    //esta funcion notifica y actualiza el estado a todo el mundo que esta escuchando y usando el valor de heroe
    notifyListeners();
  }
}
