import 'dart:math';

import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Toolbox/AboutExcercises/Buttons/ButtonGoAboutExcercises.dart';
import 'package:appkinsonFront/views/Toolbox/AboutFood/Buttons/ButtonGoAboutFood.dart';
import 'package:appkinsonFront/views/Toolbox/AboutNews/Buttons/ButtonGoAboutNews.dart';
import 'package:appkinsonFront/views/Toolbox/AboutParkinson/Buttons/ButtonGoAboutParkinson.dart';
import 'package:appkinsonFront/views/Toolbox/Pedometer/Buttons/ButtonGoPedometer.dart';
import 'package:appkinsonFront/views/sideMenus/CustomDrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:decimal/decimal.dart';

import 'Buttons/ButtonGoGame.dart';


class toolboxCuidador extends StatefulWidget {
  @override
  _toolboxCuidador0 createState() => _toolboxCuidador0();
}

String tipe;
class _toolboxCuidador0 extends State<toolboxCuidador> {
  // double percent=0.1;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: ButtonGoAboutParkinson(),
                      ),
                      Expanded(
                        child: ButtonGoAboutNews(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
