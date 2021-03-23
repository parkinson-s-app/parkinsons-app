import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetChartLine extends StatefulWidget {

  var dataLine;
  String id;
  WidgetChartLine({Key key, @required this.dataLine, @required this.id}) : super(key: key);
  _WidgetChartLineState createState() => _WidgetChartLineState(this.dataLine, this.id);
}


class _WidgetChartLineState extends State<WidgetChartLine> {
  List<charts.Series<dataLineSerie, int>> _seriesLineData;
  var dataLine;
  String id;
  _WidgetChartLineState(this.dataLine,this.id);

  _generateData(){

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


  _seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      id: 'Air Animo',
      data: data,
      domainFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.yearval,
      measureFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.dataLineSerieval,
    ),
  );
  _seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
      id: 'Air Animo',
      data: data1,
      domainFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.yearval,
      measureFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.dataLineSerieval,
    ),
  );
  _seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      id: 'Air Animo',
      data: data2,
      domainFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.yearval,
      measureFn: (dataLineSerie dataLineSerie, _) => dataLineSerie.dataLineSerieval,
    ),
  );
}
  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesLineData = List<charts.Series<dataLineSerie, int>>();
    _generateData();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Desfase en la toma de medicamentos',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold, color: Colors.teal),),
            Expanded(
              child: charts.LineChart(
                  _seriesLineData,
                  defaultRenderer: new charts.LineRendererConfig(
                      includeArea: true, stacked: true),
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.ChartTitle('Meses',
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('Desfase',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('Médicamento',
                      behaviorPosition: charts.BehaviorPosition.end,
                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea,
                    )
                  ]
              ),
            ),
          ],
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