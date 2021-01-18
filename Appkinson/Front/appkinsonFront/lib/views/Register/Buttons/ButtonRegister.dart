import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:flutter/material.dart';
import '../../../services/EndPoints.dart';
import '../InputFieldRegister.dart';
import '../../Login/LoginPage.dart';
import 'dart:convert';


class ButtonRegister extends StatefulWidget {
  @override
  ButtonRegisterCustom createState() => ButtonRegisterCustom();
}

class ButtonRegisterCustom extends State<ButtonRegister> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
            padding: EdgeInsets.symmetric(horizontal: 50),
            color: Color.fromRGBO(0, 160, 227, 1),
            textColor: Colors.white,
            child: Text("Registrarse", style: TextStyle(fontSize: 15)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          // addUsers('jorge', '1234');


          var m = new metod();
          var user = await m.send();
          debugPrint(user.email);
          String save = await EndPoints().addUsers(user);
          debugPrint(save);
          debugPrint("Valido");
          Navigator.push(context, new MaterialPageRoute( builder: (context) => LoginPage()));
          //if (save == 'Guardado') {

            var i = 0;
            var character = '';
            bool hasUppercase = false;
            bool hasSpecialCharacters = false;
            while (i < user.password.length) {
              character = user.password.toString().substring(i, i + 1);
              if (character == character.toUpperCase()) {
                hasUppercase = true;
              }
            }
            if (user.password.toString().contains(
                new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
              hasSpecialCharacters = true;
            }
            if (user.email.toString().contains('@')) {
              if (/*mas de 8 char*/ user.password
                  .toString()
                  .length > 8) {
                if (/*Mayuscula*/ hasUppercase == true) {
                  if (/*Char extra*/ hasSpecialCharacters = true) {
                    String save = await EndPoints().addUsers(user);
                    debugPrint(save);
                    if (save == 'Guardado') {
                      //RoutesGeneral().toLogin(context);

                    }
                  } else {
                    //debe contener un caracter especial
                    invalid(3);
                  }
                } else {
                  //debe tener una mayuscula
                  invalid(2);
                }
              } else {
                //muy corta
                invalid(1);
              }
            } else {
              // no es un correo valido
              invalid(0);
            }
            debugPrint(user.email);
            //if()
         // }
        },
      ),
    );
  }

  invalid(int reason) {
    String invalidReason = null;
    if(reason == 0){
      invalidReason = "El email no es un correo valido";
    }
    if(reason == 1){
      invalidReason = "La contraseña debe tener mínimo 8 caracteres";
    }
    if(reason == 2){
      invalidReason = "La contraseña debe contener mínimo una mayuscula";
    }
    if(reason == 3){
      invalidReason = "La contraseña debe contener mínimo un caracter especial";
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Form(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white60,
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      child: Text(
                        invalidReason,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "Ralewaybold",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cerrar')),
            ],
          );
        });
  }
}

