import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetPruebaLineal extends StatefulWidget {
  var dataPie;
  String id;
  WidgetPruebaLineal({Key key, @required this.dataPie, @required this.id})
      : super(key: key);
  _WidgetPruebaState createState() => _WidgetPruebaState(this.dataPie, this.id);
}

var datapie;

class _WidgetPruebaState extends State<WidgetPruebaLineal> {
  List<charts.Series<DataLinealChart1, String>> _seriesLinear;

  _WidgetPruebaState(this.dataPie, this.id);
  var dataPie;
  String id;

  _generateData(String id, var dataPie) {
    _seriesLinear.add(
      charts.Series(
        domainFn: (DataLinealChart1 dataPieChart, _) =>
            dataPieChart.valorAlfabetico,
        measureFn: (DataLinealChart1 dataPieChart, _) =>
            dataPieChart.valorNumerico,
        colorFn: (DataLinealChart1 dataPieChart, _) =>
            charts.ColorUtil.fromDartColor(dataPieChart.colorval),
        id: this.id,
        data: this.dataPie,
        labelAccessorFn: (DataLinealChart1 row, _) => '${row.valorNumerico}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesLinear = List<charts.Series<DataLinealChart1, String>>();
    _generateData("idquemado", datapie);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Promedio de estados del paciente',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: charts.LineChart(_seriesLinear,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.DatumLegend(
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 11),
                    )
                  ],
                  defaultRenderer: new charts.LineRendererConfig(
                      includeLine: true, includePoints: true)),
            ),
          ],
        ),
      ),
    );
  }
}

class DataLinealChart1 {
  String valorAlfabetico;
  double valorNumerico;
  Color colorval;

  DataLinealChart1(this.valorAlfabetico, this.valorNumerico, this.colorval);
}
