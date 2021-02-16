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
          /*String save = await EndPoints().addUsers(user);
          debugPrint(save);
          ;*/
          debugPrint("Validando");
          //if (save == 'Guardado') {

            var i = 0;
            var character = '';
            bool hasUppercase = false;
            bool hasSpecialCharacters = false;
            debugPrint(user.password.length.toString());
            while (i < user.password.length) {
              character = user.password.toString().substring(i, i + 1);
              if (character == character.toUpperCase()) {
                hasUppercase = true;
              }
              i++;
            }
            debugPrint("verificando caracteres especiales");
            if (user.password.toString().contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
              hasSpecialCharacters = true;
            }

            debugPrint("Validando condiciones");
            if (user.email.toString().contains('@')) {
              debugPrint("correo valido");
              if (/*mas de 8 char*/ user.password.toString().length > 7) {
                debugPrint("longitud valida");
                if (/*Mayuscula*/ hasUppercase == true) {
                  debugPrint("Tiene mayuscula");
                  if (/*Char extra*/ hasSpecialCharacters = true) {
                    debugPrint("contiene caracter especial");
                    String save = await EndPoints().addUsers(user);
                    debugPrint(save);
                    if (save == 'Guardado') {
                      //RoutesGeneral().toLogin(context);
                      Navigator.push(context, new MaterialPageRoute( builder: (context) => LoginPage()));
                    }
                  } else {
                    //debe contener un caracter especial
                    invalid(3,context);
                  }
                } else {
                  //debe tener una mayuscula
                  invalid(2,context);
                }
              } else {
                //muy corta
                invalid(1,context);
              }
            } else {
              // no es un correo valido
              invalid(0,context);
            }
            //if()
         // }
        },
      ),
    );
  }

}

invalid(int reason, context) {
  debugPrint("invalidez");
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
  showDialog(
    context: context,
    builder: (BuildContext context) => _buildPopupDialog(context, invalidReason),
  );
}


Widget _buildPopupDialog(BuildContext context, String invalidReason) {
  return new AlertDialog(
    title: Text (invalidReason),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cancelar'),
      ),
    ],
  );
}