import 'package:flutter/material.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoAboutParkinson extends StatelessWidget {
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
            //RoutesPatient().toCalendar(context);
          },
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[50],
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/parkinsonHand.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Sobre Parkinson",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
