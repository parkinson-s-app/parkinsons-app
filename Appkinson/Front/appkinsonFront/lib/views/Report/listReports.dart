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

var piedata; //Gráfica promedio de sintomas
var seriedata; //Gráfica promedio de sintomas por mes
var seriedataGameAverage; //Gráfica promedio de veces y puntaje jugado por mes
var serieDataDiskineias; //Gráfica de porcentaje de diskinecias entre meses
var seriesDataEmotional; //Gráfica de promedio de puntaje del formulario emocional por meses

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
          averageEmotionalSymptomsDecode.length,
          averageEmotionalSymptomsDecode);

      //seriesDataEmotional
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
                  RoutesDoctor().toReportChartSerie(
                      context, "idquemado", seriedataGameAverage);
                },
                child: Text("Promedio de destreza en el juego"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor().toReportChartPie(
                      context, "idquemado", serieDataDiskineias);
                },
                child: Text("Porcentaje de disquinecias en meses"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor().toReportChartSerie(
                      context, "idquemado", seriesDataEmotional);
                },
                child: Text(
                    "Promedio del puntaje del estado de ánimo del paciente"),
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
                child: Text("Promedio del estado de ánimo"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              /*FlatButton(
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
                child: Text(
                    "Promedio del ejercicio realizad comparado con los síntomas"),
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
        averageSymtomsByMonthResponseDecode[i]
            ['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for (int j = 0; j < length; j++) {
    //Este ciclo recoge todos los On buenos
    data2.add(new Animo(
        averageSymtomsByMonthResponseDecode[j]['onG'].toInt(),
        averageSymtomsByMonthResponseDecode[j]
            ['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data2);

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ff
    data3.add(new Animo(
        averageSymtomsByMonthResponseDecode[i]['off'].toInt(),
        averageSymtomsByMonthResponseDecode[i]
            ['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data3);
  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ON
    data4.add(new Animo(
        averageSymtomsByMonthResponseDecode[i]['offB'].toInt(),
        averageSymtomsByMonthResponseDecode[i]
            ['mes'])); // el més debemos pasarlo a String
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
        averageGameResponseDecode[i]
            ['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for (int j = 0; j < length; j++) {
    print(averageGameResponseDecode[j]['Cantidad']);
    //Este ciclo recoge la cantidad de veces jugada por mes
    data2.add(new Animo(
        averageGameResponseDecode[j]['Cantidad'],
        averageGameResponseDecode[j]
            ['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data2);

  return allData;
}

returnDataPieAverageDiskinecias(
    int length, var averageDiskineciasResponseDecode) {
  //Porcentaje de número de disquinecias por mes
  List<DataPieChart> dataDiskinecias = [];
  for (int i = 0; i < length; i++) {
    dataDiskinecias.add(new DataPieChart(
        averageDiskineciasResponseDecode[i]['mes'],
        averageDiskineciasResponseDecode[i]['Promedio'].toDouble(),
        _generateColor()));
  }

  return dataDiskinecias;
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
        averageGameResponseDecode[i]
            ['mes'])); // el més debemos pasarlo a String
  }
  allData.add(data1);

  return allData;
}
