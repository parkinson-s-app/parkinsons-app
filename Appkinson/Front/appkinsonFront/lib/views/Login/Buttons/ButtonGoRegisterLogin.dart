import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:flutter/material.dart';

import '../../Register/RegisterPage.dart';

class ButtonGoRegisterLogin extends StatelessWidget {
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
          RoutesGeneral().toRegister(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.white,
        textColor: Colors.blue,
        child: Text("¿No tienes una cuenta? ", style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
