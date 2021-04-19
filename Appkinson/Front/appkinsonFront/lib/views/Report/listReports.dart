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
String averageSymptomsByMonth;
String averageGameScore;
var piedata; //Gráfica promedio de sintomas
var seriedata; //Gráfica promedio de sintomas por mes
var seriedataGameAverage; //Gráfica promedio de veces y puntaje jugado por mes
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
     //Construyendo los datos de la gráfica de promedio de los síntomas del paciente - Gráfica de tortas
     averageSymptoms.add(averageSymtomsResponseDecode["on"].toDouble());
     averageSymptoms.add(averageSymtomsResponseDecode["onG"].toDouble());
     averageSymptoms.add(averageSymtomsResponseDecode["off"].toDouble());
     averageSymptoms.add(averageSymtomsResponseDecode["offB"].toDouble());

      piedata = returnDataPie(averageSymptoms);

      //---------------------------------------------------------------------------
      //Construyendo la gráfica del promedio de síntomas por cada mes - Gráfica de barras
      var averageSymtomsByMonthResponseDecode =  json.decode(averageSymptomsByMonth);
      seriedata = returnDataSeries(averageSymtomsByMonthResponseDecode.length, averageSymtomsByMonthResponseDecode);

      //Construyendo la gráfica de promedio de puntaje obtenido en el juego por mes - Gráfica de barras
      var averageGameResponseDecode =  json.decode(averageSymptomsByMonth);
      seriedataGameAverage = returnDataSeriesGameAverage(averageGameResponseDecode.length, averageGameResponseDecode);
      //
     });
    super.initState();
  }
  

  Future _getAllDataCharts(DateTime lastDate, DateTime now) async {
     averageSymtomsResponse = await EndPoints().getAverageSymptoms( idPatient, lastDate, now);
     averageSymptomsByMonth =  await EndPoints().getAverageSymptomsAndCheerUp( idPatient, lastDate, now); //corregir el  nombre del endpoint
     averageGameScore = await EndPoints().getAverageGame( idPatient, lastDate, now);
  }
 

  
  var linedata = returnDataLine();
   


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
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio de los sintomas del paciente por meses"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
                FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedataGameAverage);
                },
                child: Text("Promedio de destreza en el juego"),
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

returnDataSeries(int length, var averageSymtomsByMonthResponseDecode) {//GRÁFICA PROMEDIO DE LOS SÍNTOMAS DEL PACIENTE POR MES, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO

  var allData = [];
  List<Animo> data1 = []; //todos los on por cada mes
  List<Animo> data2 = []; //todos los on buenos por cada mes
  List<Animo> data3 = []; //todos los off por cada mes
  List<Animo> data4 = []; //todos los off malos por cada mes
  for(int i = 0; i<length; i++){
    //Este ciclo recoge todos los ON
     data1.add(new Animo(averageSymtomsByMonthResponseDecode[i]['on'], averageSymtomsByMonthResponseDecode[i]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for(int j = 0; j<length; j++){
    //Este ciclo recoge todos los On buenos
     data2.add(new Animo(averageSymtomsByMonthResponseDecode[j]['onG'], averageSymtomsByMonthResponseDecode[j]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data2);

  for(int i = 0; i<length; i++){
    //Este ciclo recoge todos los ff
     data3.add(new Animo(averageSymtomsByMonthResponseDecode[i]['off'], averageSymtomsByMonthResponseDecode[i]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data3);
  for(int i = 0; i<length; i++){
    //Este ciclo recoge todos los ON
     data4.add(new Animo(averageSymtomsByMonthResponseDecode[i]['offB'], averageSymtomsByMonthResponseDecode[i]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data4);
 
  return allData;
}



returnDataSeriesGameAverage(int length, var averageGameResponseDecode) {//GRÁFICA PROMEDIO DE JUEGO COMPARADO CON LA CANTIDAD, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO

  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje por cada mes
  List<Animo> data2 = []; //Cantidad Jugada por cada mes
 
  for(int i = 0; i<length; i++){
    //Este ciclo recoge el promedio de puntaje jugado por mes
     data1.add(new Animo(averageGameResponseDecode[i]['Promedio'], averageGameResponseDecode[i]['Mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for(int j = 0; j<length; j++){
    //Este ciclo recoge la cantidad de veces jugada por mes
     data2.add(new Animo(averageGameResponseDecode[j]['Cantidad'], averageGameResponseDecode[j]['Mes'])); // el més debemos pasarlo a String
  }
  allData.add(data2);
 
  return allData;
}