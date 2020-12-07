import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
//import 'DropDownRegister.dart';
//import 'DropDownRegister.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class InputFieldRegister extends StatefulWidget {
  @override
  InputFieldRegisterCustom createState() => InputFieldRegisterCustom();
}

var lista = ['Paciente', 'Doctor', 'Cuidador'];
final userSelected = TextEditingController();
String selectUser = "Seleccione un usuario";
TextEditingController emailController = new TextEditingController();

class InputFieldRegisterCustom extends State<InputFieldRegister> {
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
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Enter your password",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Enter your password again",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
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
