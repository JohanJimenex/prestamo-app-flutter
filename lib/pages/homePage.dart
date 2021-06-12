import 'package:app_prestamo/widgets/drawerMenuWidget.dart';
import 'package:app_prestamo/widgets/myText.dart';
import 'package:app_prestamo/widgets/myTextField.dart';
import 'package:app_prestamo/provider/calcProvider.dart';

import 'package:intl/intl.dart'; //para usar los metoso de format
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables
  final valorInputController = TextEditingController();
  //para relacionar y disaparar los onSave de los inputs
  final formKey = new GlobalKey<FormState>();
  final claveDelScaffold = new GlobalKey<ScaffoldState>();

  var f = NumberFormat(",###.0#", "en_US");

  double opcionSeleccionada;

  @override
  void dispose() {
    //Limpia el controlador cuando el widget se elimine del árbol de widgets
    valorInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    CalcProvider calcProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        toolbarHeight: 30.0,
        //cambiar colñor del boton de drwer
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      key: claveDelScaffold,
      drawer: DrawerMenuWidget(),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, right: 30, left: 30),
              //Formulario
              child: Form(
                key: formKey,
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
                    MyTextFormField(
                        Icon(Icons.monetization_on_outlined), "Monto préstamo"),
                    SizedBox(height: 30.0),
                    MyTextFormField(Icon(Icons.stacked_line_chart_outlined),
                        "Tasa de interés anual"),
                    SizedBox(height: 15.0),
                    _dropDown(),
                    SizedBox(height: 20.0),
                    MyText(
                      "Cuota mensual : \$\ ${f.format(calcProvider.cuotaMensual)}",
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    Row(
                      children: [
                        MyText(
                          "Monto total : \$\ ${f.format(calcProvider.montoTotal)}",
                          fontWeight: FontWeight.normal,
                        ),
                        MyText(
                          "  \$\ ${f.format(calcProvider.montoTotal)}",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    _btnCalcular(),
                    SizedBox(height: 20.0),
                    MyText(
                      "Tabla de amortización:",
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ), //Tabla
            _filterBox()
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    CalcProvider calcProvider = Provider.of(context);

    return DropdownButtonFormField<double>(
      value: opcionSeleccionada,

      validator: (double valor) {
        if (valor == null) {
          return "Seleccionar tiempo";
        } else {
          return null;
        }
      },
      hint: Text('Tiempo...',
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20)), //acepta un widget,
      //Al igual que 'hint' agrega un valor por defecto,
      //OJASO: TOMAR en cuenta que debe ser uno de los valores existente en la lista por ejemplo el 6 12 24 etc o un string si son string

      items: [
        DropdownMenuItem(child: Text("6 meses"), value: 6.00),
        DropdownMenuItem(child: Text("12 meses (1 año)"), value: 12.00),
        DropdownMenuItem(child: Text("24 meses (2 años)"), value: 24.00),
        DropdownMenuItem(child: Text("36 meses (3 años)"), value: 36.00),
        DropdownMenuItem(child: Text("48 meses (4 años)"), value: 48.00),
        DropdownMenuItem(child: Text("60 meses (5 años)"), value: 60.00),
      ],
      //se ejecuta al cambiar
      //toma el valor seleccionado

      onChanged: (double mesesSeleccionados) {
        setState(() {
          opcionSeleccionada = mesesSeleccionados;
          calcProvider.cantidadMeses = mesesSeleccionados;
        });
      },
    );
  }

  Widget _btnCalcular() {
    CalcProvider calcProvider = Provider.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // primary: Colors.blueGrey[600],
        shape: StadiumBorder(),
        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
      ),
      child:
          Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 20)),
      onPressed: () {
        //devuelve true o false
        formKey.currentState.validate();
        //dispara los onSave d elos textField
        formKey.currentState.save();

        calcProvider.calcular();
      },
    );
  }

  Widget _filterBox() {
    CalcProvider calcProvider = Provider.of(context);
    int numeroCuota = 1;

    List<DataRow> listaDataRow = [];

    for (Map<String, double> item in calcProvider.listaDatos) {
      listaDataRow.add(
        DataRow(
          cells: <DataCell>[
            DataCell(MyText("${numeroCuota++}", tamano: 15)),
            DataCell(Text('\$ ${f.format(item["cuotaMensual"])}')),
            DataCell(Text('\$ ${f.format(item["interes"])}')),
            DataCell(Text('\$ ${f.format(item["capital"])}')),
            DataCell(Text('\$ ${f.format(item["balance"])}')),
          ],
        ),
      );
    }

    return FittedBox(
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
        rows: listaDataRow,
      ),
    );
  }
}
