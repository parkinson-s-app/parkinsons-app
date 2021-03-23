import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Pie.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_lineal.dart';
import 'package:flutter/material.dart';

class listReportPage extends StatelessWidget {
  var piedata = returnDataPie();
  var linealdata = returnDataLineal();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Reportes',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('Reportes')),
            body: new ListView(children: [
              FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartPie(context, "idquemado", piedata);
                },
                child: Text("Promedio de los sintomas del paciente"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                  onPressed: null, //RoutesDoctor()
                  //.toReportChartLineal(context, "idquemado", linealdata),
                  child: Text("Promedio del estado de ánimo del paciente")),
              FlatButton(
                  onPressed: null,
                  child:
                      Text("Promedio de desfase en la toma de médicamentos")),
            ])));
  }
}

returnDataPie() {
  var piedata = [
    //new DataPieChart('ON', 35.8, Color(0xff3366cc)),
    //new DataPieChart('OFF', 8.3, Color(0xff990099)),
    new DataPieChart('ON MUY BUENO', 10.8, Color(0xff109618)),
    new DataPieChart('ON BUENO', 15.6, Colors.lightGreen),
    new DataPieChart('OFF MALO', 19.2, Color(0xffff9900)),
    new DataPieChart('OFF MUY MALO', 10.3, Color(0xffdc3912)),
  ];
  return piedata;
}

returnDataLineal() {
  var linealdata = [
    //new DataPieChart('ON', 35.8, Color(0xff3366cc)),
    //new DataPieChart('OFF', 8.3, Color(0xff990099)),
    new DataLinealChart1('ON MUY BUENO', 10.8, Color(0xff109618)),
    new DataLinealChart1('ON BUENO', 15.6, Colors.lightGreen),
    new DataLinealChart1('OFF MALO', 19.2, Color(0xffff9900)),
    new DataLinealChart1('OFF MUY MALO', 10.3, Color(0xffdc3912)),
  ];
  return linealdata;
}
