import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class WidgetChartLine extends StatefulWidget {
  var dataLine;
  var id;
  String titulo;
  String ejex;
  String ejey;
  String description;
  WidgetChartLine({Key key, @required this.dataLine, @required this.id, @required this.titulo,
   @required this.ejex, @required this.ejey, @required this.description})
      : super(key: key);
  _WidgetChartLineState createState() =>
      _WidgetChartLineState(this.dataLine, this.id,this.titulo,this.ejex,this.ejey,this.description);
}

class _WidgetChartLineState extends State<WidgetChartLine> {
  List<charts.Series<dataLineSerie, int>> _seriesLineData;
  var dataLine;
  var id;
  String titulo;
  String ejex;
  String ejey;
  String description;
  _WidgetChartLineState(this.dataLine, this.id,this.titulo,this.ejex,this.ejey, this.description);

_buildDataDescription(dataLine){
  String finalData = "";
  for(int i = 0; i<dataLine.length; i++){
    for(int j = 0; j< dataLine[i].length; j++){
      finalData = finalData + dataLine[i][j].yearval.toString() + " mes : " +  dataLine[i][j].dataLineSerieval.toString() + " minutos de desfase \n";
    }
    print(finalData);
    return finalData;
  }

  return finalData;
}

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
          id: id[0],
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
                titulo,
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
                       new charts.SeriesLegend(
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                      color: charts.Color(r: 127, g: 63, b: 191),
                      fontFamily: 'Georgia',
                      fontSize: 11),
                      desiredMaxRows: 2,
                    ),
                      new charts.ChartTitle(ejex,
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle(ejey,
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      /*new charts.ChartTitle(
                        'Médicamento',
                        behaviorPosition: charts.BehaviorPosition.end,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      )*/
                    ]),
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
              TextSpan(text: description + '\n \n', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
              TextSpan(text: ' Datos: \n \n ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, 
              color: Colors.blue)),
              TextSpan(text: 'A continuación, encuentra los datos que se encuentran graficados: \n\n', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
              TextSpan(text: _buildDataDescription(dataLine), style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
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

class dataLineSerie {
  int yearval;
  int dataLineSerieval;

  dataLineSerie(this.yearval, this.dataLineSerieval);
}
