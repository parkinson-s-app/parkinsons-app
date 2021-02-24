import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesGeneral().toLogin(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.grey[100],
        textColor: Colors.blue,
        child: Text("Iniciar Sesión ", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
