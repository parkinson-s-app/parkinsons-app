import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:flutter/material.dart';

class ButtonGoFormFeelsFromCarer extends StatelessWidget {
  final int idPatient;

  ButtonGoFormFeelsFromCarer({@required this.idPatient});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: RaisedButton(
        shape: CircleBorder(),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesPatient().toFeelsForm(context, idPatient);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/6-SENTIMIENTOS.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
