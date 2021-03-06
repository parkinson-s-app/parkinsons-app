import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:flutter/material.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        //shape:
        //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesPatient().toNotifications(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        //color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/advertir.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
