import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesGeneral().toRegister(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.blue[700],
        textColor: Colors.white,
        // child: Image.asset(
        //  "assets/images/cerebroAzul.png",
        // height: size.height * 0.25,
        //  ),
        child: Text("Registrarse ", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
