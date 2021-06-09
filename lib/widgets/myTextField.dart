// import 'package:app_prestamo/provider/calcProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MyTextField extends StatelessWidget {
//   final Icon icono;
//   final String txtPlaceHolder;

//   MyTextField(this.icono, this.txtPlaceHolder);

//   @override
//   Widget build(BuildContext context) {
//     //controlador para el textfield import services
//     var valorInputController = TextEditingController();
//     final calcProvider = new CalcProvider();

//     return TextField(
//       controller: valorInputController,
//       keyboardType: TextInputType.number,
//       inputFormatters: <TextInputFormatter>[
//         FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//       ],
//       textAlign: TextAlign.center,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//         labelText: txtPlaceHolder,
//         // helperText: "Digite el monto", //texto ayuda
//         prefixIcon: icono, //icono al inicio
//       ),
//       onChanged: (String valorEscrito) {
//         // setState(() {});

//         switch (txtPlaceHolder) {
//           case "Monto préstamo":
//             calcProvider.setMonto = int.parse(valorEscrito);
//             // print(valorEscrito);
//             break;
//           case "Tasa de interés anual":
//             calcProvider.setTasaAnual = int.parse(valorEscrito);
//             // print(valorEscrito);
//             break;
//           default:
//         }
//       },
//     );
//   }
// }
