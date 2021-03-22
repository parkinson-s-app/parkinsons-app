import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Administrator/ListItemsAdministrator.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';

class ButtonGoCheckUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {

          items = await EndPoints().getItemsToolbox(currentUser['id'].toString(), token);
            RoutesAdmin().toListItems(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/formulario.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
