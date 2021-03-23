import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetChartPie extends StatefulWidget {

  var dataPie;
  String id;
  WidgetChartPie({Key key, @required this.dataPie, @required this.id}) : super(key: key);
  _WidgetChartPieState createState() => _WidgetChartPieState(this.dataPie, this.id);
}


var datapie;
class _WidgetChartPieState extends State<WidgetChartPie> {
  List<charts.Series<DataPieChart, String>> _seriesPieData;

  _WidgetChartPieState(this.dataPie,this.id);
  var dataPie;
  String id;

  _generateData(String id, var dataPie ) {

    _seriesPieData.add(
      charts.Series(
        domainFn: (DataPieChart dataPieChart, _) => dataPieChart.valorAlfabetico,
        measureFn: (DataPieChart dataPieChart, _) => dataPieChart.valorNumerico,
        colorFn: (DataPieChart dataPieChart, _) =>
            charts.ColorUtil.fromDartColor(dataPieChart.colorval),
        id: this.id,
        data: this.dataPie,
        labelAccessorFn: (DataPieChart row, _) => '${row.valorNumerico}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<DataPieChart, String>>();
    _generateData("idquemado", datapie);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Promedio de estados del paciente',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold, color: Colors.teal),),
            SizedBox(height: 10.0,),
            Expanded(
              child: charts.PieChart(
                  _seriesPieData,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.DatumLegend(
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 11),
                    )
                  ],
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 100,
                      arcRendererDecorators: [
                        new charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside)
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}

class DataPieChart {
  String valorAlfabetico;
  double valorNumerico;
  Color colorval;

  DataPieChart(this.valorAlfabetico, this.valorNumerico, this.colorval);
}
