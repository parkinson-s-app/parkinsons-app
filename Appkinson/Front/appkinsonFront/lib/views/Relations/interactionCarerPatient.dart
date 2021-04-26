import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoCalendarFromCarer.dart';
import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoCalendarFromDoctor.dart';
import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoFormFeelsFromCarer.dart';
import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoFormNoMotoresFromCarer.dart';
import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoMedicinesFromCarer.dart';
import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoMedicinesFromDoctor.dart';
import 'package:appkinsonFront/views/Relations/Buttons/ButtonGoReporter.dart';
import 'package:appkinsonFront/views/sideMenus/CustomDrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

class InteractionCarerPatient extends StatelessWidget {
  final int idPatient;

  const InteractionCarerPatient({Key key, this.idPatient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //print('patient pantalla intermedia ${idPatient.toString()}');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[400], Colors.blue[900]],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/starsBackGround.png"),
                )),
            child: Expanded(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/images/coronadr.png",
                    width: 150,
                    fit: BoxFit.fitWidth,
                    height: size.height * 0.4,
                    alignment: Alignment.bottomLeft,
                  ),
                  Positioned(
                      top: 70,
                      left: 200,
                      child: Text(
                        "¡A cuidar!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "Raleway2"),
                      )),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      ButtonGoCalendarFromCarer(),
                      Text(
                        "Calendario",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 17,
                            fontFamily: "Raleway2"),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: <Widget>[
                      ButtonGoFormFeelsFromCarer(
                        idPatient: this.idPatient,
                      ),
                      Text(
                        "Sentimientos",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 17,
                            fontFamily: "Raleway2"),
                      )
                    ],
                  ),
                  /* Column(
                        children: <Widget>[
                          ButtonGoMedicinesFromDoctor(idPatient: this.idPatient,),
                          Text(
                            "Medicamentos",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20,
                                fontFamily: "Raleway2"),
                          )
                        ],
                      ),*/
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      ButtonGoMedicinesFromCarer(
                        idPatient: this.idPatient,
                      ),
                      Text(
                        "Medicamentos \n",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 17,
                            fontFamily: "Raleway2"),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Column(children: [
                    ButtonGoFormNoMotoresFromCarer(
                      idPatient: this.idPatient,
                    ),
                    Text(
                      "Formulario Síntomas \nNo Motores",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 17,
                          fontFamily: "Raleway2"),
                    )
                  ])
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.width, size.width, size.width - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
