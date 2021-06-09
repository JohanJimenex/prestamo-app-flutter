import 'dart:math';

import 'package:app_prestamo/widgets/myText.dart';
import 'package:intl/intl.dart'; //agregarla l pubspec.yaml   intl:
import 'package:flutter/material.dart';

class CalcProvider extends ChangeNotifier {
  //paraformatear montos a dinero
  //agregar al pubspec.yaml  dependencie intl:
  //var f = NumberFormat.simpleCurrency();
  //f.format(montoPrestamo).toString();

  int _montoPrestamo;
  int _tasa;
  int _cantidadMeses;

  int _saldoInicial;
  int _cuotaMensual;

  List<DataRow> _listaDataRow = [];

  //Getters
  int get getTiempo => _cantidadMeses;
  int get getMontoPrestamo => _montoPrestamo;

  //Setters
  set setMonto(int montoPrestamo) {
    _montoPrestamo = montoPrestamo;
  }

  set setTasaAnual(int tasaAnual) {
    _tasa = tasaAnual;
  }

  set setTiempo(int cantidadMeses) {
    _cantidadMeses = cantidadMeses;
  }

  //esta funcion notifica y actualiza el estado a todo el mundo que esta escuchando y usando el valor de heroe
  //notifyListeners();

  get getcalcular {
    _saldoInicial = _montoPrestamo;
    _cuotaMensual = _montoPrestamo *
        ((pow((1 + _tasa ~/ 100), _cantidadMeses) * (_tasa ~/ 100)) ~/
            (pow((1 + _tasa ~/ 100), _cantidadMeses) - 1));

    // notifyListeners();

    // for (int i = 0; i < _cantidadMeses; i++) {
    //   _listaDataRow.add(
    //     DataRow(
    //       cells: <DataCell>[
    //         DataCell(MyText('1', tamano: 15)),
    //         DataCell(Text('\$ ${1}')),
    //         DataCell(Text('\$ ${1}')),
    //         DataCell(Text('\$ 1,550.00')),
    //         DataCell(Text('\$ 55,050.00')),
    //       ],
    //     ),
    //   );
    // }
    return;
  }
}
