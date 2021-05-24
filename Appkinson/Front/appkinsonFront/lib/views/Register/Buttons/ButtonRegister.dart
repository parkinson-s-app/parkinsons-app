import 'package:flutter/material.dart';
import '../../../services/EndPoints.dart';
import '../InputFieldRegister.dart';
import '../../Login/LoginPage.dart';
import 'package:email_validator/email_validator.dart';

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
            debugPrint("Validando condiciones");
            if (EmailValidator.validate(user.email)) {
              debugPrint("correo valido");
              if (/*mas de 8 char*/ user.password.toString().length > 7) {
                if(user.passwordVerify.toString() == user.password.toString()){
                  debugPrint("longitud valida");
                    String save = await EndPoints().addUsers(user);
                    debugPrint(save);
                    if (save == 'Guardado') {
                      //RoutesGeneral().toLogin(context);
                      //probar
                      //emailController = null;
                      cleanRegister();
                      Navigator.pop(context);
                    }else if(save == 'Existe'){
                      //register
                      invalid(2,context);
                    }
                }else{
                  debugPrint("----------");
                  debugPrint(user.passwordVerify.toString());
                  debugPrint(user.password.toString());
                  invalid(3,context);
                }    
            } else {
              //muy corta
              invalid(1, context);
            }
          } else {
            // no es un correo valido
            invalid(0, context);
          }
        },
      ),
    );
  }
}

invalid(int reason, context) {
  debugPrint("invalidez");
  String invalidReason = null;
  if (reason == 0) {
    invalidReason = "El email no es un correo valido";
  }
  if (reason == 1) {
    invalidReason = "La contraseña debe tener mínimo 8 caracteres";
  }
  if (reason == 2) {
    invalidReason = "Este usuario ya existe";
  }
  if (reason == 3) {
    invalidReason = "Las contraseñas no coinciden";
  }
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        _buildPopupDialog(context, invalidReason),
  );
}

Widget _buildPopupDialog(BuildContext context, String invalidReason) {
  return new AlertDialog(
    title: Text(invalidReason),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cerrar'),
      ),
    ],
  );
}
