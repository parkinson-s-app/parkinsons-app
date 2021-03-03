import 'dart:convert';
import 'package:appkinsonFront/model/User.dart';
import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/profiles/Doctor/DoctorProfileScreen.dart';
import 'package:flutter/material.dart';

class ProfileEditionDoctor extends StatefulWidget {
  @override
  __ProfileEdition createState() => __ProfileEdition();
}

TextEditingController nameControllerDoctor = new TextEditingController();

class __ProfileEdition extends State<ProfileEditionDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200]))),
        child: TextField(
          controller: nameControllerDoctor,
          decoration: InputDecoration(
              hintText: "Ingrese su nombre",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ),
      ),
      FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          var m = new metod2();
          var user = await m.send();
          debugPrint(user.name);
          /*
          var lista = token.split(".");
          var payload = lista[1];

          switch (payload.length % 4) {
            case 1:
              break; // this case can't be handled well, because 3 padding chars is illeagal.
            case 2:
              payload = payload + "==";
              break;
            case 3:
              payload = payload + "=";
              break;
          }

          var decoded = utf8.decode(base64.decode(payload));
          currentUser = json.decode(decoded);
          debugPrint(currentUser['id'].toString());
          */
          String save = await EndPoints()
              .modifyUsers(user, currentUser['id'].toString(), token);

          debugPrint(save);

          setState(() {
            nameDoctor = nameControllerDoctor.text;
          });

          if (save == 'Actualizado') {
            RoutesGeneral().toPop(context);
          }

          RoutesGeneral().toPop(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.white,
        textColor: Colors.blue,
        child: Text("Confirmar cambios", style: TextStyle(fontSize: 13)),
      ),
    ]));
  }
}

class metod2 {
  Future<User> send() async {
    var newUser = new User(name: nameControllerDoctor.text);
    debugPrint(newUser.name);
    return newUser;
  }
}
