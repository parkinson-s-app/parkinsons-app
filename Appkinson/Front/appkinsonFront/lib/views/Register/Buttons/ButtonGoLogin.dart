import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/views/Login/LoginPage.dart';
import 'package:flutter/material.dart';

class ButtonGoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => LoginPage());
          Navigator.pushReplacement(context, route);
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.white,
        textColor: Colors.blue,
        child: Text("¿Ya Tiene una Cuenta? ", style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
