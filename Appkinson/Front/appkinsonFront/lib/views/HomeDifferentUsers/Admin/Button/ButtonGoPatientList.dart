import 'package:flutter/material.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoModifiToolBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          //Navigator.push(context,
          //  new MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/abrir-caja.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
