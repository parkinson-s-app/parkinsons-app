import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
//import 'DropDownRegister.dart';
//import 'DropDownRegister.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class InputFieldRegister extends StatefulWidget {
<<<<<<< HEAD
  @override
  InputFieldRegisterCustom createState() => InputFieldRegisterCustom();
}

var lista = ['Paciente', 'Doctor', 'Cuidador'];
final userSelected = TextEditingController();
String selectUser = "Seleccione un usuario";
TextEditingController emailController = new TextEditingController();

class InputFieldRegisterCustom extends State<InputFieldRegister> {
=======

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
>>>>>>> 20be14a6eab3669031c3145d4bebc7a0436fbaac
  @override
  Widget build(BuildContext context) {
    var currentValue = 'Paciente';
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              //SvgPicture.asset("assets/icons/usuarioAzul.svg"),
              Positioned(
                  child: Image.asset(
                "assets/images/usuario.png",
                height: size.height * 0.03,
              )),
              SizedBox(width: 20),
              Expanded(
                  child: DropdownButton(
                isExpanded: true,
                items: lista.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectUser = value;
                  });
                },
                hint: Text(selectUser),
              )),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            controller: emailController,
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

class metod {
  Future<String> send() async {
    return emailController.text;
  }
}
