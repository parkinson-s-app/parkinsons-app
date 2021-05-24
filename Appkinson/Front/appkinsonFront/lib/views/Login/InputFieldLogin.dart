import 'package:appkinsonFront/views/Register/InputFieldRegister.dart';
import 'package:flutter/material.dart';
import '../../model/User.dart';

class InputFieldLogin extends StatefulWidget {
  @override
  __FormInputFieldLogin createState() => __FormInputFieldLogin();
}

TextEditingController emailController = new TextEditingController();
TextEditingController password = new TextEditingController();

class __FormInputFieldLogin extends State<InputFieldLogin> {
  bool _obscurePassword = true;
  String _password;
  String _correo;

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String prueba = "prueba";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "Ingrese su Correo Eléctronico",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
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
                  controller: password,
                  decoration: const InputDecoration(
                    hintText: "Ingrese su Contraseña",
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
      ],
    );
  }
}

class metod {
  Future<User> send() async {
    var newUser =
        new User(email: emailController.text, password: password.text);
    debugPrint(newUser.password);
    return newUser;
  }
}

cleanLogin() {
  emailController = new TextEditingController();
  password = new TextEditingController();
}
