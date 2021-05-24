import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/EmotionalForm/EmotionalFormQ1.dart';
import 'package:flutter/material.dart';
import '../../../EmotionalForm/EmotionalFormQ.dart';

class ButtonGoWeeklyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        shape: CircleBorder(),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String id = await Utils().getFromToken('id');
          String token = await Utils().getToken();
          RoutesPatient().toFeelsForm(context, int.parse(id));
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/6-SENTIMIENTOS.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
