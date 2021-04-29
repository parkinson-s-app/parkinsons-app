import 'package:flutter/material.dart';
import 'Buttons/ButtonLogin.dart';
import 'Buttons/ButtonRegister.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return shouldPop;
        },
        child: Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, 
            colors: [
              Colors.white,
              Colors.yellow[200],
              Colors.blue,
              Colors.blue[700],
            ]
          )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 140,
            ),
            Center(
              child: Text(
                "AppKinson",
                style: TextStyle(
                  color: Colors.indigo[900], 
                  fontSize: 40, 
                  fontFamily: "Raleway"
                ),
              ),
            ),
            Center(
              child: Text(
                "Aplicación para la Enfermedad de Parkinson",
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 14,
                  fontFamily: "RalewayBold"
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                "assets/images/cerebroMovimiento.png",
                height: size.height * 0.35,
              )
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "¡Bienvenido!",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 30, 
                  fontFamily: "Raleway"
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ButtonLogin(),
            SizedBox(
              height: 10,
            ),
            ButtonRegister(),
          ]
        ),
      )
    ));
  }
}
