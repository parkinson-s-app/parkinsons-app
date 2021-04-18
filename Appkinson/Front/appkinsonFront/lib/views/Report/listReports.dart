import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Line.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Pie.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_lineal.dart';
import 'package:flutter/material.dart';

import 'Widget_Chart_Serie.dart';


class ListReportPage extends StatefulWidget {
 final int idPatient;

  const ListReportPage({Key key, this.idPatient}) : super(key: key);
  _ListReportPage createState() => _ListReportPage(idPatient);
  
  
}

class _ListReportPage extends State<ListReportPage> {

   final int idPatient;

  _ListReportPage(this.idPatient);
  
  @override
  void initState() {
    var now = DateTime.now();
   var lastDate = new DateTime(now.year , now.month , now.day - 7);
    print("Entra al init state");
    _getAllDataCharts(lastDate, now).then((value){
   //   //aquí empezamos a llamar las funciones que construyen los arreglos de las gráficas
     });
   // _getAverageSymptomsAndCheerUp(lastDate, now).then((value){
     // aquí empezamos a llamar las funciones que construyen los arreglos de las gráficas
   // });
    super.initState();
  }
  

  Future _getAllDataCharts(DateTime lastDate, DateTime now) async {
     await EndPoints().getAverageSymptoms( idPatient, lastDate, now);
     await EndPoints().getAverageSymptomsAndCheerUp( idPatient, lastDate, now);
  }
 

  var piedata = returnDataPie();
  var linedata = returnDataLine();
  var seriedata = returnDataSeries();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Entraaaaa");
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
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
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartLine(context, "idquemado", linedata);
                },
                child: Text("Promedio de desfase en la toma de médicamentos"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del estado de ánimo del paciente"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
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

returnDataLine() {
  var allData = [];
  var data = [
    new dataLineSerie(0, 45), // mes y desfase calculado
    new dataLineSerie(1, 56),
    new dataLineSerie(2, 55),
    new dataLineSerie(3, 60),
    new dataLineSerie(4, 61),
    new dataLineSerie(5, 70),
  ];
  var data1 = [
    new dataLineSerie(0, 35),
    new dataLineSerie(1, 46),
    new dataLineSerie(2, 45),
    new dataLineSerie(3, 50),
    new dataLineSerie(4, 51),
    new dataLineSerie(5, 60),
  ];

  var data2 = [
    new dataLineSerie(0, 20),
    new dataLineSerie(1, 24),
    new dataLineSerie(2, 25),
    new dataLineSerie(3, 40),
    new dataLineSerie(4, 45),
    new dataLineSerie(5, 60),
  ];
  allData.add(data);
  allData.add(data1);
  allData.add(data2);
  return allData;
}

returnDataSeries() {
  var allData = [];
  var data1 = [
    // en enero el estado de off malo
    new Animo(15, "Enero"),
    new Animo(10, "Febrero"),
    new Animo(10, "Marzo"),
  ];
  var data2 = [
    new Animo(10, "Enero"), // en enero el estado de off normal
    new Animo(20, "Febrero"),
    new Animo(10, "Marzo"),
  ];
  var data3 = [
    new Animo(10, "Enero"), // en enero el estado de on normal
    new Animo(10, "Febrero"),
    new Animo(35, "Marzo"),
  ];
  var data4 = [
    new Animo(10, "Enero"), // en enero el estado de on muy bueno
    new Animo(10, "Febrero"),
    new Animo(35, "Marzo"),
  ];
  var data5 = [
    new Animo(10, "Enero"), // en enero el promedio de desfase de la medicina
    new Animo(10, "Febrero"),
    new Animo(35, "Marzo"),
  ];
  allData.add(data1);
  allData.add(data2);
  allData.add(data3);
  allData.add(data4);
  allData.add(data5);
  return allData;
}