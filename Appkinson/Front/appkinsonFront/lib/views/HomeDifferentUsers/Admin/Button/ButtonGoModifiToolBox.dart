import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:flutter/material.dart';

class ButtonGoModifiToolBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesAdmin().toFormAddItem(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: Colors.grey[100],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/5-TOOLBOX-PROACTIVIDAD.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
