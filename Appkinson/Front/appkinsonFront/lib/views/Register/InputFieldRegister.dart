import 'package:flutter/material.dart';

class InputFieldRegister extends StatefulWidget {

  @override
    _InputFieldRegister createState() => _InputFieldRegister();
  }

  class _InputFieldRegister extends State<InputFieldRegister> {

    bool _obscurePassword = true;
    bool _obscureVerPassword = true;
    String _password;

    void _toggle(){
      setState(() {
        _obscurePassword = !_obscurePassword;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Ingrese su correo eléctronico",
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
                  decoration: const InputDecoration(
                    hintText: "Ingrese su contraseña",
                  ),
                  obscureText: _obscurePassword,
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: _toggle,
                  child: new Icon(_obscurePassword ? Icons.remove_red_eye_sharp: Icons.remove_red_eye_outlined),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Vuelva a Ingresar su contraseña",
                  ),
                  obscureText: _obscureVerPassword,
                ),
              ),
            ],
          ),
        ),
        Container(

        ),
      ],
    );
  }
}
