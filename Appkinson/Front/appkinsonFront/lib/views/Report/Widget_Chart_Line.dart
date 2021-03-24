import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class WidgetChartLine extends StatefulWidget {
  var dataLine;
  String id;
  WidgetChartLine({Key key, @required this.dataLine, @required this.id})
      : super(key: key);
  _WidgetChartLineState createState() =>
      _WidgetChartLineState(this.dataLine, this.id);
}

class _WidgetChartLineState extends State<WidgetChartLine> {
  List<charts.Series<dataLineSerie, int>> _seriesLineData;
  var dataLine;
  String id;
  _WidgetChartLineState(this.dataLine, this.id);

  _generateColor() {
    var colors = [];
    for (int i = 0; i < dataLine.length; i++) {
      Color colorItem;
      colorItem = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      colors.add(colorItem);
    }
    return colors;
  }

  _generateData() {
    var colors = _generateColor();
    print(dataLine);

    for (int i = 0; i < dataLine.length; i++) {
      _seriesLineData.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(colors[i]),
          id: this.id + i.toString(),
          data: dataLine[i],
          domainFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.yearval,
          measureFn: (dataLineSerie dataLineSerie, _) =>
              dataLineSerie.dataLineSerieval,
        ),
      );
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesLineData = List<charts.Series<dataLineSerie, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Desfase toma medicamentos",
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Desfase en la toma de medicamentos',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              Expanded(
                child: charts.LineChart(_seriesLineData,
                    defaultRenderer: new charts.LineRendererConfig(
                        includeArea: true, stacked: true),
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.ChartTitle('Meses',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle('Desfase',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle(
                        'Médicamento',
                        behaviorPosition: charts.BehaviorPosition.end,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class dataLineSerie {
  int yearval;
  int dataLineSerieval;

  dataLineSerie(this.yearval, this.dataLineSerieval);
}
