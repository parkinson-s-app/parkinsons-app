import 'dart:math';

import 'package:appkinsonFront/views/ToolBox/AboutExcercises/Buttons/ButtonGoAboutExcercises.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/Buttons/ButtonGoAboutFood.dart';
import 'package:appkinsonFront/views/ToolBox/AboutNews/Buttons/ButtonGoAboutNews.dart';
import 'package:appkinsonFront/views/ToolBox/AboutParkinson/Buttons/ButtonGoAboutParkinson.dart';
import 'package:appkinsonFront/views/ToolBox/Pedometer/Buttons/ButtonGoPedometer.dart';
import 'package:appkinsonFront/views/sideMenus/CustomDrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:pedometer/pedometer.dart';
import 'package:decimal/decimal.dart';

import 'Buttons/ButtonGoGame.dart';

class toolbox extends StatefulWidget {
  @override
  _toolbox0 createState() => _toolbox0();
}

class _toolbox0 extends State<toolbox> {
  String muestrePasos = "0";
  String _km = "0";
  String _calories = "0";

  String _stepCountValue = '0';
  StreamSubscription<int> _subscription;

  double numero_pasos;
  double _convert;
  double _kmx;
  double burnedx;
  double _porciento;
  // double percent=0.1;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    // setUpPedometer();
  }

  /*void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }*/

  void _onData(int stepCountValue) async {
    // print(stepCountValue);
    setState(() {
      _stepCountValue = "$stepCountValue";
      // print(_stepCountValue);
    });

    var dist = stepCountValue;
    double y = (dist + .0);

    setState(() {
      numero_pasos = y;
    });

    var long3 = (numero_pasos);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(numero_pasos);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  void getDistanceRun(double numero_pasos) {
    var distance = ((numero_pasos * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2));
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

  @override
  Widget build(BuildContext context) {
    getBurnedRun();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades y juego'),
      ),
      body: ListView(
        padding: EdgeInsets.all(2.0),
        children: <Widget>[
          new Container(
            width: 80,
            height: 750,
            child: Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ButtonGoAboutExcercises(),
                      ),
                      Expanded(
                        child: ButtonGoAboutFood(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*Expanded(
                                child: ButtonGoAboutParkinson(),
                              ),*/
                      Expanded(
                        child: ButtonGoGame(),
                      ),
                      Expanded(
                        child: ButtonGoAboutNews(),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /* Expanded(
                          child: ButtonGoPedometer(),
                        ),*/
                        Expanded(
                          child: ButtonGoAboutParkinson(),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
