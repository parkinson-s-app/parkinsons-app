import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetChartSerie extends StatefulWidget {
  var dataSerie;
  String id;
  WidgetChartSerie({Key key, @required this.dataSerie, @required this.id}) : super(key: key);

  _WidgetChartSerieState createState() => _WidgetChartSerieState(this.dataSerie, this.id);
}

class _WidgetChartSerieState extends State<WidgetChartSerie> {
  List<charts.Series<Animo, String>> _seriesData;

  _WidgetChartSerieState(this.dataPie,this.id);
  var dataPie;
  String id;


//Gráfica de lineas/
  _generateData() {
    var data1 = [
      new Animo(15,"Enero"),
   //   new Animo(10,"Febrero"),
   //   new Animo(10,"Marzo"),
    ];
    var data2 = [
    //  new Animo(10, "Enero"),
      new Animo(20,"Febrero"),
    //  new Animo(10,"Marzo"),
    ];
    var data3 = [
    //  new Animo(10, "Enero"),
    //  new Animo(10,"Febrero"),
      new Animo(35,"Marzo"),
    ];


    _seriesData.add(
      charts.Series(
        domainFn: (Animo Animo, _) => Animo.mes,
        measureFn: (Animo Animo, _) => Animo.estadoDeAnimo,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Animo Animo, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Animo Animo, _) => Animo.mes,
        measureFn: (Animo Animo, _) => Animo.estadoDeAnimo,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Animo Animo, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Animo Animo, _) => Animo.mes,
        measureFn: (Animo Animo, _) => Animo.estadoDeAnimo,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Animo Animo, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

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
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Puntaje de ánimo en el paciente',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold, color: Colors.teal),),
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
    );
  }
}

class Animo {
  int estadoDeAnimo;
  String mes;

  Animo(this.estadoDeAnimo, this.mes);
}
