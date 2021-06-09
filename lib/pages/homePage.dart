import 'package:app_prestamo/provider/calcProvider.dart';
import 'package:app_prestamo/widgets/myText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalcProvider calcProvider = new CalcProvider();
  final valorInputController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    valorInputController.dispose();
    super.dispose();
  }

  int opcionSeleccionada;

  int tempMontoPrestamo;
  int tempTasa;
  int tempCantidadMeses;

  @override
  Widget build(BuildContext context) {
    calcProvider.getMontoPrestamo;

    return Scaffold(
      // appBar: AppBar(title: Text("Calculadora de préstamo")),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, right: 30, left: 30),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Calculadora de Préstamo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PoetsenOne",
                          color: Colors.deepPurple[900],
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  myTextField(
                      Icon(Icons.monetization_on_outlined), "Monto préstamo"),
                  SizedBox(height: 30.0),
                  myTextField(Icon(Icons.stacked_line_chart_outlined),
                      "Tasa de interés anual"),
                  SizedBox(height: 15.0),
                  DropdownButton<int>(
                    hint: Text('Tiempo...',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20)), //acepta un widget,
                    //Al igual que 'hint' agrega un valor por defecto,
                    //OJASO: TOMAR en cuenta que debe ser uno de los valores existente en la lista por ejemplo el 6 12 24 etc o un string si son string
                    value: opcionSeleccionada,
                    items: [
                      DropdownMenuItem(child: Text("6 meses"), value: 6),
                      DropdownMenuItem(
                          child: Text("12 meses (1 año)"), value: 12),
                      DropdownMenuItem(
                          child: Text("24 meses (2 años)"), value: 24),
                      DropdownMenuItem(
                          child: Text("36 meses (3 años)"), value: 36),
                      DropdownMenuItem(
                          child: Text("48 meses (4 años)"), value: 48),
                      DropdownMenuItem(
                          child: Text("60 meses (5 años)"), value: 60),
                    ],
                    //se ejecuta al cambiar
                    //toma el valor seleccionado
                    onChanged: (int tiempoSeleccionado) {
                      setState(() {
                        opcionSeleccionada = tiempoSeleccionado;
                        tempCantidadMeses = tiempoSeleccionado;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text("Cuota mensual : \$\{\}"),
                  Text("Monto total a pagar al finalizar préstamo: \$\{\}"),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.blueGrey[600],
                      shape: StadiumBorder(),
                      padding: EdgeInsets.only(
                          left: 40, right: 40, top: 10, bottom: 10),
                    ),
                    child: Text('Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      calcProvider.setMonto = tempMontoPrestamo;
                      calcProvider.setTasaAnual = tempTasa;
                      calcProvider.setTiempo = tempCantidadMeses;
                      calcProvider.getcalcular();
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text("Tabla de amortización:"),
                ],
              ),
            ), //Tabla
            FittedBox(
              // fit: BoxFit.none,
              child: DataTable(
                dataRowHeight: 40.00,
                headingRowHeight: 40,
                horizontalMargin: 20,
                columnSpacing: 20,
                columns: [
                  DataColumn(label: MyText('')),
                  DataColumn(label: MyText('Cuota')),
                  DataColumn(label: MyText('Interés')),
                  DataColumn(label: MyText('Capital')),
                  DataColumn(label: MyText('Balance')),
                ],
                // rows: generarTabla(),
                // rows: calcProvider.getListaRows,
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      DataCell(MyText('1', tamano: 15)),
                      DataCell(Text('\$ ${1}')),
                      DataCell(Text('\$ ${1}')),
                      DataCell(Text('\$ 1,550.00')),
                      DataCell(Text('\$ 55,050.00')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> generarTabla() {
    List<DataRow> listaFilas = [];

    for (int i = 0; i < calcProvider.getTiempo; i++) {
      listaFilas.add(
        DataRow(
          cells: <DataCell>[
            DataCell(MyText('1', tamano: 15)),
            DataCell(Text('\$ ${1}')),
            DataCell(Text('\$ ${1}')),
            DataCell(Text('\$ 1,550.00')),
            DataCell(Text('\$ 55,050.00')),
          ],
        ),
      );
    }

    return listaFilas;
  }

  Widget myTextField(Icon icono, String txtPlaceHolder) {
    //controlador para el textfield import services
    var valorInputController = TextEditingController();

    return TextField(
      controller: valorInputController,
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
      onChanged: (String valorEscrito) {
        // setState(() {});
        print(valorInputController.text);

        switch (txtPlaceHolder) {
          case "Monto préstamo":
            tempMontoPrestamo = int.parse(valorEscrito);

            break;
          case "Tasa de interés anual":
            tempTasa = int.parse(valorEscrito);

            break;
          default:
        }
      },
    );
  }
}
