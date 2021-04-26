import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:flutter/material.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoPedometer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        RaisedButton(
          shape: CircleBorder(),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
          onPressed: () {
            RoutesPatient().toGame(context);
          },
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[50],
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/9-PODOMETRO.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Podómetro",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
