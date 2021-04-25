import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/Buttons/ButtonGoNoMotorSymptoms.dart';
import 'package:flutter/material.dart';
import 'Buttons/ButtonGoCalendar.dart';
import 'Buttons/ButtonGoProfile.dart';
import 'Buttons/ButtonGoRelationsRequest.dart';
import 'Buttons/ButtonGoReminder.dart';
import 'Buttons/ButtonGoMedicinesSchedule.dart';
import 'Buttons/ButtonGoToolBox.dart';
import 'Buttons/ButtonGoWeeklyForm.dart';

class PatientHomePage extends StatelessWidget {
  bool shouldPop = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
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
                        Positioned(
                          top: 265,
                          left: 255,
                          child: ButtonGoRelationsRequest(),
                        ),
                        /*
                        Positioned(
                          top: 250,
                          right: 125,
                          child: ButtonGoReminder(),
                        ),
                        */
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
                              "¿Qué \nharemos \nhoy?",
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
                height: 30,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ButtonGoCalendar(),
                            Text(
                              "Calendario \n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 20,
                                  fontFamily: "Raleway2"),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ButtonGoMedicinesSchedule(),
                            Text(
                              "Medicinas \n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 20,
                                  fontFamily: "Raleway2"),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ButtonGoNoMotorSymptoms(),
                            Text(
                              "Formulario \nNo motores",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 20,
                                  fontFamily: "Raleway2"),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ButtonGoProfile(),
                            Text(
                              "Perfil \n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 20,
                                  fontFamily: "Raleway2"),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ButtonGoToolBox(),
                            Text(
                              "Actividades &\n Juegos",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 18,
                                  fontFamily: "Raleway2"),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ButtonGoWeeklyForm(),
                            Text(
                              "Formulario \nSentimientos",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 20,
                                  fontFamily: "Raleway2"),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
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
