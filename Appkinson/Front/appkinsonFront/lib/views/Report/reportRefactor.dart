import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportPageRefactor extends StatefulWidget {
  final Widget child;

  ReportPageRefactor({Key key, this.child}) : super(key: key);

  _ReportPageRefactorState createState() => _ReportPageRefactorState();
}

class _ReportPageRefactorState extends State<ReportPageRefactor> {
  List<charts.Series<Animo, String>> _seriesData;
  List<charts.Series<Sintomas, String>> _seriesPieData;
  List<charts.Series<TomaMedicamentos, int>> _seriesLineData;

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

    var piedata = [
      //new Sintomas('ON', 35.8, Color(0xff3366cc)),
      //new Sintomas('OFF', 8.3, Color(0xff990099)),
      new Sintomas('ON MUY BUENO', 10.8, Color(0xff109618)),
      new Sintomas('ON BUENO', 15.6, Color(0xfffdbe19)),
      new Sintomas('OFF MALO', 19.2, Color(0xffff9900)),
      new Sintomas('OFF MUY MALO', 10.3, Color(0xffdc3912)),
    ];

    var lineTomaMedicamentosdata = [
      new TomaMedicamentos(0, 45), // mes y desfase calculado
      new TomaMedicamentos(1, 56),
      new TomaMedicamentos(2, 55),
      new TomaMedicamentos(3, 60),
      new TomaMedicamentos(4, 61),
      new TomaMedicamentos(5, 70),
    ];
    var lineTomaMedicamentosdata1 = [
      new TomaMedicamentos(0, 35),
      new TomaMedicamentos(1, 46),
      new TomaMedicamentos(2, 45),
      new TomaMedicamentos(3, 50),
      new TomaMedicamentos(4, 51),
      new TomaMedicamentos(5, 60),
    ];

    var lineTomaMedicamentosdata2 = [
      new TomaMedicamentos(0, 20),
      new TomaMedicamentos(1, 24),
      new TomaMedicamentos(2, 25),
      new TomaMedicamentos(3, 40),
      new TomaMedicamentos(4, 45),
      new TomaMedicamentos(5, 60),
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

    _seriesPieData.add(
      charts.Series(
        domainFn: (Sintomas Sintomas, _) => Sintomas.sintoma,
        measureFn: (Sintomas Sintomas, _) => Sintomas.Sintomasvalue,
        colorFn: (Sintomas Sintomas, _) =>
            charts.ColorUtil.fromDartColor(Sintomas.colorval),
        id: 'Air Animo',
        data: piedata,
        labelAccessorFn: (Sintomas row, _) => '${row.Sintomasvalue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Animo',
        data: lineTomaMedicamentosdata,
        domainFn: (TomaMedicamentos TomaMedicamentos, _) => TomaMedicamentos.yearval,
        measureFn: (TomaMedicamentos TomaMedicamentos, _) => TomaMedicamentos.TomaMedicamentosval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Animo',
        data: lineTomaMedicamentosdata1,
        domainFn: (TomaMedicamentos TomaMedicamentos, _) => TomaMedicamentos.yearval,
        measureFn: (TomaMedicamentos TomaMedicamentos, _) => TomaMedicamentos.TomaMedicamentosval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Animo',
        data: lineTomaMedicamentosdata2,
        domainFn: (TomaMedicamentos TomaMedicamentos, _) => TomaMedicamentos.yearval,
        measureFn: (TomaMedicamentos TomaMedicamentos, _) => TomaMedicamentos.TomaMedicamentosval,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Animo, String>>();
    _seriesPieData = List<charts.Series<Sintomas, String>>();
    _seriesLineData = List<charts.Series<TomaMedicamentos, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Puntaje de ánimo en el paciente',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
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
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Promedio de estados del paciente',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
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
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Desfase en la toma de medicamentos',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
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

class Sintomas {
  String sintoma;
  double Sintomasvalue;
  Color colorval;

  Sintomas(this.sintoma, this.Sintomasvalue, this.colorval);
}

class TomaMedicamentos {
  int yearval;
  int TomaMedicamentosval;

  TomaMedicamentos(this.yearval, this.TomaMedicamentosval);
}
