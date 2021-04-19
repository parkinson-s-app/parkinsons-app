import 'dart:convert';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Line.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Pie.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_lineal.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'Widget_Chart_Serie.dart';

String averageSymtomsResponse;
String averageSymptomsByMonth;
String averageGameScore;
String averageDyskineciasWithoutMonth;
String averageEmotionalSymptoms;
String dataDisrepancy;

var piedata; //Gráfica promedio de sintomas
var seriedata; //Gráfica promedio de sintomas por mes
var seriedataGameAverage; //Gráfica promedio de veces y puntaje jugado por mes
var serieDataDiskineias; //Gráfica de porcentaje de diskinecias entre meses
var seriesDataEmotional; //Gráfica de promedio de puntaje del formulario emocional por meses
var lineDataMedicinesDiscrepacy; //Gráfica de discrepancia del tiempo de toma de médicamento

class ListReportPage extends StatefulWidget {
 final int idPatient;
  List<DateTime> picked;

   ListReportPage({Key key, this.idPatient, this.picked}) : super(key: key);
  _ListReportPage createState() => _ListReportPage(idPatient, picked);

}

class _ListReportPage extends State<ListReportPage> {

   final int idPatient;
   List<DateTime> picked;

  _ListReportPage(this.idPatient, this.picked);
  
  @override
  void initState() {
    print("BUENASSSSSSSS");
    print(picked[0]);
    print(picked[1]);
    print("________________________");
    var now = picked[1];
    var lastDate = picked[0];
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
      //Construyeno la gráfica de porcentaje de disquinecias por meses - Gráfica de pie
      var averageDyskineciasDecode = json.decode(averageDyskineciasWithoutMonth);
      serieDataDiskineias = returnDataPieAverageDiskinecias(averageDyskineciasDecode.length, averageDyskineciasDecode);

      //Construyendo la gráfica de promedio de puntaje del formulario emocional por meses
      var averageEmotionalSymptomsDecode = json.decode(averageEmotionalSymptoms);
      seriesDataEmotional = returnDataSeriesEmotionalAverage(averageDyskineciasDecode.length, averageDyskineciasDecode);
      
      //Construyendo la gráfica de disrepania en los tiempos de toma de médicamentos
      var discrepandyDataDecode = json.decode(dataDisrepancy);
      lineDataMedicinesDiscrepacy = returnDataLine(discrepandyDataDecode.length, discrepandyDataDecode);
     });
     
    super.initState();
  }
  

  Future _getAllDataCharts(DateTime lastDate, DateTime now) async {
     averageSymtomsResponse = await EndPoints().getAverageSymptoms( idPatient, lastDate, now);
     averageSymptomsByMonth =  await EndPoints().getAverageSymptomsAndCheerUp( idPatient, lastDate, now); //corregir el  nombre del endpoint
     averageGameScore = await EndPoints().getAverageGame( idPatient, lastDate, now);
     averageDyskineciasWithoutMonth = await EndPoints().getAverageDyskineciasWithoutMonths( idPatient, lastDate, now);
     averageEmotionalSymptoms = await EndPoints().getAverageEmotionalSymptoms( idPatient, lastDate, now);
     print("nuevaa");
     dataDisrepancy = await EndPoints().getDiscrepancyData( idPatient, lastDate, now);
  }

   


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
                child: Text("Porcentaje de los síntomas del paciente"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
                FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio de los síntomas del paciente por meses"),
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
                      .toReportChartSerie(context, "idquemado", serieDataDiskineias);
                },
                child: Text("Porcentaje de disquinecias en meses"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
                 FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriesDataEmotional);
                },
                child: Text("Promedio del puntaje del estado de ánimo del paciente"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartLine(context, "idquemado", lineDataMedicinesDiscrepacy);
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
                child: Text("Promedio del estado de ánimo"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              
            /*    FlatButton(
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
                child: Text("Promedio del ejercicio realizado comparado con los síntomas"),
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
              ),*/
            ])));
  }
}
//Esta función debería estar en utils
  _generateColor() {
    
   var colorItem = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
    return colorItem;
  }


returnDataPie(List<double> datos) {
  var linealdata = [
    new DataPieChart('ON MUY BUENO', datos[1], Color(0xff109618)),
    new DataPieChart('ON BUENO', datos[0], Colors.lightGreen),
    new DataPieChart('OFF MALO', datos[2], Color(0xffff9900)),
    new DataPieChart('OFF MUY MALO', datos[3], Color(0xffdc3912)),
  ];
  return linealdata;
}

returnDataLine(int length, var discrepancyaDataDecode) { //Gráfica de discrepancia del tiempo en la toma de médicamentos
  var allData = [];
  List<dataLineSerie> data = [];
  for(int i=0; i<length; i++ ){
    data.add(new dataLineSerie(3, discrepancyaDataDecode[i]['Promedio']));  // mes y promedio en tiempo del desfase calculado
  }
  allData.add(data);
 
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
     data1.add(new Animo(averageGameResponseDecode[i]['Promedio'], averageGameResponseDecode[i]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for(int j = 0; j<length; j++){
    //Este ciclo recoge la cantidad de veces jugada por mes
     data2.add(new Animo(averageGameResponseDecode[j]['Cantidad'], averageGameResponseDecode[j]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data2);
 
  return allData;
}

returnDataPieAverageDiskinecias(int length, var averageDiskineciasResponseDecode) {
  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje del formulario por cada mes
 
  for(int i = 0; i<length; i++){
    //Este ciclo recoge el promedio de puntaje de disquinecias por mes
     data1.add(new Animo(averageDiskineciasResponseDecode[i]['Promedio'], averageDiskineciasResponseDecode[i]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);
 
  return allData;
}


returnDataSeriesEmotionalAverage(int length, var averageGameResponseDecode) {//GRÁFICA PROMEDIO DE JUEGO COMPARADO CON LA CANTIDAD, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO
  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje del formulario por cada mes
 
  for(int i = 0; i<length; i++){
    //Este ciclo recoge el promedio de puntaje del formulario emocional por mes
     data1.add(new Animo(averageGameResponseDecode[i]['Promedio'], averageGameResponseDecode[i]['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);
 
  return allData;
}