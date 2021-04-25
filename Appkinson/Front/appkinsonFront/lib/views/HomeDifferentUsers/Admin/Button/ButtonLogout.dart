import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/HomeInitial/HomePage.dart';
import 'package:appkinsonFront/views/Login/InputFieldLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: RaisedButton(
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          debugPrint("Tapped Log Out....");
          cleanLogin();
          Navigator.push(context,
              MaterialPageRoute(builder: (context){ return HomePage();}));
        },
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/cerrar-sesion.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
