import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/Button/ButtonGoCheckItems.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/Button/ButtonGoModifiToolBox.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/Button/ButtonLogout.dart';
import 'package:flutter/material.dart';


class AdminHomePage extends StatelessWidget {
  bool shouldPop = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
    child: Scaffold(
        body: Column(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[400], Colors.blue[900]],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/starsBackGround.png"),
                )),
            child: Expanded(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/images/ingenieria.png",
                    width: 150,
                    fit: BoxFit.fitWidth,
                    height: size.height * 0.4,
                    alignment: Alignment.bottomLeft,
                  ),
                   Positioned(
                      top: 70,
                      left: 200,
                      child: Text(
                        "  \nAdministrador \n",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "Raleway2"),
                      ))
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Container(
          child: Wrap(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ButtonGoModifiToolBox(),
                      Text(
                        "ToolBox",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            fontFamily: "Raleway2"),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ButtonGoCheckItems(),
                      Text(
                        "Items",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            fontFamily: "Raleway2"),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ButtonLogout(),
                      Text(
                        "Cerrar Sesión",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            fontFamily: "Raleway2"),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    )));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.width, size.width, size.width - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}