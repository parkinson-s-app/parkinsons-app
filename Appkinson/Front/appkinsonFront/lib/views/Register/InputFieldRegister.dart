import 'package:flutter/material.dart';
import '../../model/User.dart';
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
TextEditingController password = new TextEditingController();

class InputFieldRegisterCustom extends State<InputFieldRegister> {
  bool _obscurePassword = true;
  bool _obscureVerPassword = true;
  String _password;
  final validationKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentValue = 'Paciente';
    Size size = MediaQuery.of(context).size;
    return Form(
      key: validationKey,
      child: Column(
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
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]))),
            child: TextFormField(
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
                    controller: password,
                    decoration: const InputDecoration(
                      hintText: "Ingrese su contraseña",
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      hintText: "Vuelva a Ingresar su contraseña",
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}

class metod {
  Future<User> send() async {
    var newUser = new User(
        email: emailController.text, password: password.text, type: selectUser);
    debugPrint(newUser.password);
    return newUser;
  }
}
