import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/resetPassword/passwordChange.dart';
import 'package:flutter/material.dart';

class PasswordChangeOtm extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController passwordRecoverController = new TextEditingController();
TextEditingController passwordRecoverController2 = new TextEditingController();
TextEditingController codController = new TextEditingController();

class _LoginPageState extends State<PasswordChangeOtm> {
  bool _obscurePassword = true;
  bool _obscureVerPassword = true;

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cambiar contraseña",
          ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
            ),
          ],
        ),
        body: Center(
            child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: codController,
              decoration: InputDecoration(
                  hintText: "Ingresa el codigo enviado a tu correo!",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: TextFormField(
                      controller: passwordRecoverController,
                      decoration: const InputDecoration(
                        hintText: "Ingrese su nueva contraseña",
                      ),
                      obscureText: _obscurePassword,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: TextFormField(
                      controller: passwordRecoverController2,
                      decoration: const InputDecoration(
                        hintText: "Ingrese su contraseña de nuevo",
                      ),
                      obscureText: _obscurePassword,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _toggle,
                      child: new Icon(_obscurePassword
                          ? Icons.remove_red_eye_sharp
                          : Icons.remove_red_eye_outlined),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0))),
                onPressed: () {
                  print('hey');
                  if (passwordRecoverController2.text ==
                      passwordRecoverController.text) {
                    int otpInt = int.parse(codController.text);
                    EndPoints().newPasswordRecover(emailRecoverController.text,
                        passwordRecoverController2.text, otpInt);
                    RoutesGeneral().toLogin(context);
                  } else {
                    invalid(3, context);
                  }
                },
                child: Text(
                  'Cambiar Contraseña',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )));
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
