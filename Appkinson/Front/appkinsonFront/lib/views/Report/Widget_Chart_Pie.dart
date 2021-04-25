import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetChartPie extends StatefulWidget {
  var dataPie;
  String id;
  String tituloGrafica;
  String descripcion;
  WidgetChartPie({Key key, @required this.dataPie, @required this.id, @required this.tituloGrafica,
  @required this.descripcion})
      : super(key: key);
  _WidgetChartPieState createState() =>
      _WidgetChartPieState(this.dataPie, this.id, this.tituloGrafica, this.descripcion);
}

var datapie;

class _WidgetChartPieState extends State<WidgetChartPie> {
  List<charts.Series<DataPieChart, String>> _seriesPieData;

  _WidgetChartPieState(this.dataPie, this.id, this.tituloGrafica, this.descripcion);
  var dataPie;
  String id;
  String tituloGrafica;
  String descripcion;
  String dataDescriptionBuild;
_buildDataDescription(var dataPie){
    String finalData = "";
    for(int i = 0; i< dataPie.length; i++){
        finalData = finalData + dataPie[i].valorAlfabetico + " : " + dataPie[i].valorNumerico.toString() + "\n";
    }
    return finalData;
}

  _generateData(String id, var dataPie) {
    _seriesPieData.add(
      charts.Series(
        domainFn: (DataPieChart dataPieChart, _) =>
            dataPieChart.valorAlfabetico,
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
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.bar_chart)),
                Tab(icon: Icon(Icons.description)),
              ],
            ),
            title: Text(''),
          ),
           body:  TabBarView(
            children: [
         Container(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Promedio estados paciente",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0),
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
      ),
              Container(
          padding: EdgeInsets.all(60),
          decoration: BoxDecoration(
           // borderRadius: BorderRadius.circular(13),
            color: Colors.white,
          ),
          child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Descripción: \n \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, 
              color: Colors.blue)),
              TextSpan(text: descripcion + '\n \n', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
              TextSpan(text: ' Datos: \n \n ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, 
              color: Colors.blue)),
              TextSpan(text: 'A continuación, encuentra los datos que se encuentran graficados: \n\n', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
              TextSpan(text: _buildDataDescription(dataPie), style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
            ],
          ),
        )
           
        ),
            ],
          ),
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
