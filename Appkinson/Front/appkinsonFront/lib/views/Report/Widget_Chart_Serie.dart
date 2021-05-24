import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class WidgetChartSerie extends StatefulWidget {
  var dataSerie;
  String titulo;
  var id;
  var colors;
  String ejex;
  String ejeY;
  String description;
  String dataDescription;
  WidgetChartSerie({Key key, @required this.dataSerie, @required this.id, @required this.titulo,
  @required this.colors, @required this.ejex, @required this.ejeY, @required this.description,
  @required this.dataDescription})
      : super(key: key);

  _WidgetChartSerieState createState() =>
      _WidgetChartSerieState(this.dataSerie, this.id, this.titulo, this.colors, this.ejex,
      this.ejeY, this.description, this.dataDescription);
}

class _WidgetChartSerieState extends State<WidgetChartSerie> {
  List<charts.Series<Animo, String>> _seriesData;

  _WidgetChartSerieState(this.dataSerie, this.id, this.titulo, this.colors,
  this.ejex, this.ejeY, this.description, this.dataDescription);
  var dataSerie;
  var id;
  String titulo;
  var colors;
  String ejex;
  String ejeY;
  String description;
  String dataDescription;

_buildDataDescription(dataSerie){
  String finalData = "";
  for(int i = 0; i<dataSerie.length; i++){
     
    for(int j = 0; j< dataSerie[i].length; j++){
    print("AGAINN");
     print(dataSerie[i].length);
   
      finalData = finalData + dataSerie[i][j].mes + " : \n" +  
      dataSerie[i][j].estadoDeAnimo.toString() + " \n";
      print(i.toString() + " " + j.toString());
    }
    return finalData;
  }

  return finalData;
}
//Gráfica de lineas/
  _generateData() {
    
    for (int i = 0; i < dataSerie.length; i++) {
      _seriesData.add(
        charts.Series(
          domainFn: (Animo Animo, _) => Animo.mes,
          measureFn: (Animo Animo, _) => Animo.estadoDeAnimo,
          
          data: dataSerie[i],
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          
          colorFn: (Animo Animo, _) =>
              charts.ColorUtil.fromDartColor(colors[i]),
          id: id[i],
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
                    color: Colors.blue),
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesData,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
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
                     new charts.ChartTitle(ejeY,
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                  ],
                  animationDuration: Duration(seconds: 5),
                ),
              ),
            ],
          ),
        ),
      ),
             Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
           // borderRadius: BorderRadius.circular(13),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
            elevation: 2,
            color:  Colors.white,
            //color:  Color.fromRGBO(146 , 205, 227, 1),
            child:
             ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              children: <TextSpan>[
              TextSpan(text: 'Descripción \n \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, 
              color: Colors.blue)),
            ],
          ),
        ),
             RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
              children: <TextSpan>[
              TextSpan(text: description + '\n \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
            ],
          ),
        ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              children: <TextSpan>[
              TextSpan(text: ' Datos: \n \n ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, 
              color: Colors.blue)),
            ],
          ),
        ),
          RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
              children: <TextSpan>[
              TextSpan(text: 'A continuación, encuentra los datos que se encuentran graficados: \n\n', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
              color: Colors.black26)),
            ],
          ),
        ),
          RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
              children: <TextSpan>[
              TextSpan(text: dataDescription, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, 
              color: Colors.green)),
            ],
          ),
        ),
            ]
          ),
            
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

class Animo {
  double estadoDeAnimo;
  String mes;

  Animo(this.estadoDeAnimo, this.mes);
}
