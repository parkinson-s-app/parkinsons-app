import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:flutter/material.dart';
import 'InputFieldLogin.dart';
import 'Buttons/ButtonLogin.dart';
import 'Buttons/ButtonGoRegisterLogin.dart';

class InputWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: InputFieldLogin(),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {
                  print('hey');
                  RoutesGeneral().toChangePassword(context);
                },
                child: Text('¿olvidaste tu contraseña?')),
            SizedBox(
              height: 40,
            ),
            ButtonLogin(),
            SizedBox(
              height: 40,
            ),
            ButtonGoRegisterLogin()
          ],
        ),
      ),
    );
  }
}
