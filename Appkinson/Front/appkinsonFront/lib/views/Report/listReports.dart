import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Line.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Pie.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_lineal.dart';
import 'package:flutter/material.dart';

import 'Widget_Chart_Serie.dart';
String averageSymtomsResponse;
var piedata;
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
   
     var averageSymtomsResponseDecode =  json.decode(averageSymtomsResponse);
     List<double> averageSymptoms = [];
     //Construyendo los datos de la gráfica de promedio de los síntomas del paciente
     averageSymptoms.add(averageSymtomsResponseDecode["on"].toDouble());
     averageSymptoms.add(averageSymtomsResponseDecode["onG"].toDouble());
     averageSymptoms.add(averageSymtomsResponseDecode["off"].toDouble());
     averageSymptoms.add(averageSymtomsResponseDecode["offB"].toDouble());
    
    print(averageSymptoms[0]);
    print(averageSymptoms[1]);
    print(averageSymptoms[2]);
    print(averageSymptoms[3]);

    piedata = returnDataPie(averageSymptoms);

     });
    super.initState();
  }
  

  Future _getAllDataCharts(DateTime lastDate, DateTime now) async {
     averageSymtomsResponse = await EndPoints().getAverageSymptoms( idPatient, lastDate, now);
     await EndPoints().getAverageSymptomsAndCheerUp( idPatient, lastDate, now);
     await EndPoints().getAverageGame( idPatient, lastDate, now);
  }
 

  
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
                FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio de disquinecias"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
                FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del estado de ánimo"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
                FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio de destreza"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
                FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del ejercicio realizado"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
               FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del ejercicio realizad comparado con los síntomas"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
               FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del ejercicio realizado comparado con el ánimo"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ])));
  }
}


returnDataPie(List<double> datos) {
  var linealdata = [
    //new DataPieChart('ON', 35.8, Color(0xff3366cc)),
    //new DataPieChart('OFF', 8.3, Color(0xff990099)),
    new DataPieChart('ON MUY BUENO', datos[1], Color(0xff109618)),
    new DataPieChart('ON BUENO', datos[0], Colors.lightGreen),
    new DataPieChart('OFF MALO', datos[2], Color(0xffff9900)),
    new DataPieChart('OFF MUY MALO', datos[3], Color(0xffdc3912)),
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
