import 'package:app_prestamo/provider/calcProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyTextFormField extends StatelessWidget {
  final Icon icono;
  final String txtPlaceHolder;

  MyTextFormField(this.icono, this.txtPlaceHolder);

  @override
  Widget build(BuildContext context) {
    CalcProvider calcProvider = Provider.of(context);
    // final valorInputController = TextEditingController();

    return TextFormField(
        // controller: valorInputController,
        // initialValue: "0",

        validator: (String valor) {
          if (valor == "") {
            return "Ingresar monto";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: txtPlaceHolder,
          // helperText: "Digite el monto", //texto ayuda
          prefixIcon: icono, //icono al inicio
        ),
        onSaved: (String valorEscrito) {
          switch (txtPlaceHolder) {
            case "Monto préstamo":
              calcProvider.montoPrestamo = double.parse(valorEscrito);
              break;

            case "Tasa de interés anual":
              calcProvider.tasaAnual = double.parse(valorEscrito);
              break;

            default:
          }
        });
  }
}
