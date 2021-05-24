import 'package:flutter/material.dart';

class HeaderRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              "Registro",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Appkinson",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
