import 'dart:convert';
import 'package:appkinsonFront/model/User.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfileScreen.dart';
import 'package:flutter/material.dart';

class ProfileEditionCarer extends StatefulWidget {
  @override
  __ProfileEdition createState() => __ProfileEdition();
}

TextEditingController nameControllerCarer = new TextEditingController();

class __ProfileEdition extends State<ProfileEditionCarer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cambio de Nombre"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: TextField(
                controller: nameControllerCarer,
                decoration: InputDecoration(
                    hintText: "Ingrese su Nombre",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
              onPressed: () async {
                var m = new metod2();
                var user = await m.send();

                setState(() {
                  nameCarer = nameControllerCarer.text;
                });

                String id = await Utils().getFromToken('id');
                String token = await Utils().getToken();
                String save = await EndPoints().modifyUsers(user, id, token);
                debugPrint(save);

                setState(() {
                  nameCarer = nameControllerCarer.text;
                });

                if (save == 'Actualizado') {
                  Navigator.pop(context);
                }

                Navigator.pop(context);
              },
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Confirmar cambios", style: TextStyle(fontSize: 13)),
            ),
          ]),
        ));
  }
}

class metod2 {
  Future<User> send() async {
    var newUser = new User(name: nameControllerCarer.text);
    debugPrint(newUser.name);
    return newUser;
  }
}
