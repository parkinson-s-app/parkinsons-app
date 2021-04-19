import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class WidgetChartSerie extends StatefulWidget {
  var dataSerie;
  
  String id;
  WidgetChartSerie({Key key, @required this.dataSerie, @required this.id})
      : super(key: key);

  _WidgetChartSerieState createState() =>
      _WidgetChartSerieState(this.dataSerie, this.id);
}

class _WidgetChartSerieState extends State<WidgetChartSerie> {
  List<charts.Series<Animo, String>> _seriesData;

  _WidgetChartSerieState(this.dataSerie, this.id);
  var dataSerie;
  String id;
   
  _generateColor() {
    var colors = [];
    for (int i = 0; i < dataSerie.length; i++) {
      Color colorItem;
      colorItem = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      colors.add(colorItem);
    }
    return colors;
  }

//Gráfica de lineas/
  _generateData() {
    var colors = _generateColor();
    for (int i = 0; i < dataSerie.length; i++) {
      _seriesData.add(
        charts.Series(
          domainFn: (Animo Animo, _) => Animo.mes,
          measureFn: (Animo Animo, _) => Animo.estadoDeAnimo,
          id: '2017',
          data: dataSerie[i],
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (Animo Animo, _) =>
              charts.ColorUtil.fromDartColor(colors[i]),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Animo, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Puntaje Animo Paciente",
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Puntaje de ánimo en el paciente',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesData,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                  //behaviors: [new charts.SeriesLegend()],
                  animationDuration: Duration(seconds: 5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Animo {
  int estadoDeAnimo;
  String mes;

  Animo(this.estadoDeAnimo, this.mes);
}
