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

//COLORES
var colorsSintomasPorMeses = _generateColorsSyntomsChart();

//IDS
var idsSymptomsAverage = ['ON MUY BUENO', 'ON', 'OFF', 'OFF MUY MALO'];
var idsAverageGame  = ['PUNTAJE', 'CANTIDAD JUGADA'];
var idsDyskineciasAverage = ['DISQUINECIAS'];
var idsEmotionalAverage = ['ÁNIMO'];
var idsMedicinesAverage = ['LEVODOPA'];

//DESCRIPCIONES
String descripcionSymptoms = "Esta gráfica fue construida sumando la cantidad de registros existentes en el intervalo de tiempo escogido y sacando el porcentaje de cada uno de los síntomas sobre dicho total";
String descriptionSymptomsByMonth ="Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se saca el promedio de cada uno de los síntomas en dichos meses";
String descriptionAverageGame = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula el promedio de los puntajes obtenidos en cada mes, además de gráficar la cantidad de veces que jugó en el mes";
String descriptionDysquinecias = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula cuántos de los registros existentes tuvieron disquinecias en cada mes";
String descriptionEmotional = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula el puntaje promedio obtenido en cada mes";
String descriptionMedicines = "Esta gráfica  construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula el promedio de tiempo en minutos que tuvo de desfase en la toma del médicamento";

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
    _getAllDataCharts(lastDate, now).then((value) {
      var averageSymtomsResponseDecode = json.decode(averageSymtomsResponse);
      List<double> averageSymptoms = [];
      //Construyendo los datos de la gráfica de promedio de los síntomas del paciente - Gráfica de tortas
      averageSymptoms.add(averageSymtomsResponseDecode["on"].toDouble());
      averageSymptoms.add(averageSymtomsResponseDecode["onG"].toDouble());
      averageSymptoms.add(averageSymtomsResponseDecode["off"].toDouble());
      averageSymptoms.add(averageSymtomsResponseDecode["offB"].toDouble());

      piedata = returnDataPie(averageSymptoms);

      //---------------------------------------------------------------------------
      //Construyendo la gráfica del promedio de síntomas por cada mes - Gráfica de barras
      var averageSymtomsByMonthResponseDecode =
          json.decode(averageSymptomsByMonth);
      seriedata = returnDataSeries(averageSymtomsByMonthResponseDecode.length,
          averageSymtomsByMonthResponseDecode);

      //Construyendo la gráfica de promedio de puntaje obtenido en el juego por mes - Gráfica de barras
      var averageGameResponseDecode = json.decode(averageGameScore);
      seriedataGameAverage = returnDataSeriesGameAverage(
          averageGameResponseDecode.length, averageGameResponseDecode);
      //
      //Construyeno la gráfica de porcentaje de disquinecias por meses - Gráfica de pie
      var averageDyskineciasDecode =
          json.decode(averageDyskineciasWithoutMonth);
      serieDataDiskineias = returnDataPieAverageDiskinecias(
          averageDyskineciasDecode.length, averageDyskineciasDecode);

      //Construyendo la gráfica de promedio de puntaje del formulario emocional por meses
      var averageEmotionalSymptomsDecode =
          json.decode(averageEmotionalSymptoms);
      seriesDataEmotional = returnDataSeriesEmotionalAverage(
          averageDyskineciasDecode.length, averageDyskineciasDecode);

      //Construyendo la gráfica de disrepania en los tiempos de toma de médicamentos
      var discrepandyDataDecode = json.decode(dataDisrepancy);
      lineDataMedicinesDiscrepacy =
          returnDataLine(discrepandyDataDecode.length, discrepandyDataDecode);
    });

    super.initState();
  }

  Future _getAllDataCharts(DateTime lastDate, DateTime now) async {
    averageSymtomsResponse =
        await EndPoints().getAverageSymptoms(idPatient, lastDate, now);
    averageSymptomsByMonth = await EndPoints().getAverageSymptomsAndCheerUp(
        idPatient, lastDate, now); //corregir el  nombre del endpoint
    averageGameScore =
        await EndPoints().getAverageGame(idPatient, lastDate, now);
    averageDyskineciasWithoutMonth = await EndPoints()
        .getAverageDyskineciasWithoutMonths(idPatient, lastDate, now);
    averageEmotionalSymptoms =
        await EndPoints().getAverageEmotionalSymptoms(idPatient, lastDate, now);
    print("nuevaa");
    dataDisrepancy =
        await EndPoints().getDiscrepancyData(idPatient, lastDate, now);
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
                      .toReportChartPie(context, "idquemado", piedata, "Porcentaje de los síntomas del paciente \n",
                      descripcionSymptoms);
                },
                child: Text("Porcentaje de los síntomas del paciente"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, idsSymptomsAverage, seriedata, "Promedio de los síntomas del paciente por meses \n \n",
                      colorsSintomasPorMeses, "Mes", "Promedio de Síntomas", descriptionSymptomsByMonth);
                },
                child: Text("Promedio de los síntomas del paciente por meses"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor().toReportChartSerie(
                      context, idsAverageGame, seriedataGameAverage, "Promedio de destreza en el juego \n \n",
                      colorsSintomasPorMeses, "Mes", "Promedio del puentaje", descriptionAverageGame);
                },
                child: Text("Promedio de destreza en el juego"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor().toReportChartSerie(
                      context, idsDyskineciasAverage, serieDataDiskineias, "Porcentaje de disquinecias en meses \n \n",
                      colorsSintomasPorMeses, "Mes", "Porcentaje de disquinecias", descriptionDysquinecias);
                },
                child: Text("Porcentaje de disquinecias en meses"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor().toReportChartSerie(
                      context, idsEmotionalAverage, seriesDataEmotional, "Promedio del puntaje del estado de ánimo del paciente \n \n",
                      colorsSintomasPorMeses, "Meses", "Promedio del puntaje del estado de ánimo", descriptionEmotional);
                },
                child: Text(
                    "Promedio del puntaje del estado de ánimo del paciente"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor().toReportChartLine(
                      context, idsMedicinesAverage, lineDataMedicinesDiscrepacy, "Desfase en la toma de medicamentos \n \n",
                       "Meses", "Desfase", descriptionMedicines);
                },
                child: Text("Promedio de desfase en la toma de médicamentos"),
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
                child: Text(
                    "Promedio del ejercicio realizado comparado con el ánimo"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),*/
            ])));
  }
  
}
//____________________________DEFINIENDO LOS COLORES DE LAS GRÁFICAS______________-
_generateColorsSyntomsChart(){
var colorsSintomasPorMeses = [];
colorsSintomasPorMeses.add(Color(0xff109618));
colorsSintomasPorMeses.add(Colors.lightGreen);
colorsSintomasPorMeses.add(Color(0xffff9900));
colorsSintomasPorMeses.add(Color(0xffdc3912));
return colorsSintomasPorMeses;
}

//_________________________FUNCIÓN PARA PASAR LOS MESES DE INT A CADENA_______________-
String toMonthString(int month){
  
  if(month == 1){ return "Enero";}
  if(month == 2){ return "Febrero";}
  if(month == 3){ return "Marzo";}
  if(month == 4){ return "Abril";}
  if(month == 5){ return "Mayo";}
  if(month == 6){ return "Junio";}
  if(month == 7){ return "Julio";}
  if(month == 8){ return "Agosto";}
  if(month == 9){ return "Septiembre";}
  if(month == 10){ return "Octubre";}
  if(month == 11){ return "Noviembre";}
  if(month == 12){ return "Diciembre";}
  return "Mes no encontrado";
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

returnDataLine(int length, var discrepancyaDataDecode) {
  //Gráfica de discrepancia del tiempo en la toma de médicamentos
  var allData = [];
  List<dataLineSerie> data = [];
  for (int i = 0; i < length; i++) {
    data.add(new dataLineSerie(
        discrepancyaDataDecode[i]['mes'],
        discrepancyaDataDecode[i]['Promedio']
            .toInt())); // mes y promedio en tiempo del desfase calculado
  }
  allData.add(data);

  return allData;
}

returnDataSeries(int length, var averageSymtomsByMonthResponseDecode) {
  //GRÁFICA PROMEDIO DE LOS SÍNTOMAS DEL PACIENTE POR MES, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO

  var allData = [];
  List<Animo> data1 = []; //todos los on por cada mes
  List<Animo> data2 = []; //todos los on buenos por cada mes
  List<Animo> data3 = []; //todos los off por cada mes
  List<Animo> data4 = []; //todos los off malos por cada mes
  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ON
    data1.add(new Animo(
        averageSymtomsByMonthResponseDecode[i]['on'].toInt(),
        toMonthString(averageSymtomsByMonthResponseDecode[i]
            ['mes'])
        )); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for (int j = 0; j < length; j++) {
    //Este ciclo recoge todos los On buenos
    data2.add(new Animo(
        averageSymtomsByMonthResponseDecode[j]['onG'].toInt(),
        toMonthString(averageSymtomsByMonthResponseDecode[j]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data2);

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ff
    data3.add(new Animo(
        averageSymtomsByMonthResponseDecode[i]['off'].toInt(),
        toMonthString(averageSymtomsByMonthResponseDecode[i]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data3);
  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ON
    data4.add(new Animo(
        averageSymtomsByMonthResponseDecode[i]['offB'].toInt(),
        toMonthString(averageSymtomsByMonthResponseDecode[i]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data4);

  return allData;
}

returnDataSeriesGameAverage(int length, var averageGameResponseDecode) {
  //GRÁFICA PROMEDIO DE JUEGO COMPARADO CON LA CANTIDAD, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO

  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje por cada mes
  List<Animo> data2 = []; //Cantidad Jugada por cada mes

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge el promedio de puntaje jugado por mes
    data1.add(new Animo(
        averageGameResponseDecode[i]['Promedio'],
        toMonthString(averageGameResponseDecode[i]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for (int j = 0; j < length; j++) {
    print(averageGameResponseDecode[j]['Cantidad']);
    //Este ciclo recoge la cantidad de veces jugada por mes
    data2.add(new Animo(
        averageGameResponseDecode[j]['Cantidad'],
        toMonthString(averageGameResponseDecode[j]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data2);

  return allData;
}

returnDataPieAverageDiskinecias(
    int length, var averageDiskineciasResponseDecode) {
  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje del formulario por cada mes

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge el promedio de puntaje de disquinecias por mes
    data1.add(new Animo(
        averageDiskineciasResponseDecode[i]['Promedio'].toInt(),
        toMonthString(averageDiskineciasResponseDecode[i]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data1);

  return allData;
}

returnDataSeriesEmotionalAverage(int length, var averageGameResponseDecode) {
  //GRÁFICA PROMEDIO DE JUEGO COMPARADO CON LA CANTIDAD, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO
  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje del formulario por cada mes

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge el promedio de puntaje del formulario emocional por mes
    print(averageGameResponseDecode[i]['Promedio'].toInt());
    data1.add(new Animo(
        averageGameResponseDecode[i]['Promedio'].toInt(),
        toMonthString(averageGameResponseDecode[i]
            ['mes']))); // el més debemos pasarlo a String
  }
  allData.add(data1);

  return allData;
}
