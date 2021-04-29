import 'package:flutter/material.dart';
import '../../model/User.dart';

class InputFieldRegister extends StatefulWidget {
  @override
  InputFieldRegisterCustom createState() => InputFieldRegisterCustom();
}

var lista = ['Paciente', 'Doctor', 'Cuidador'];
final userSelected = TextEditingController();
String selectUser = "Seleccione un usuario";
TextEditingController emailController = new TextEditingController();
TextEditingController nameController = new TextEditingController();
TextEditingController password = new TextEditingController();
TextEditingController passwordv = new TextEditingController();

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
                SizedBox(width: 20,
                child: Center(
                    child: Image.asset(
                  "assets/images/usuario.png",
                  height: size.height * 0.03,
                ))),
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
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Ingrese su nombre",
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
                    controller: passwordv,
                    decoration: const InputDecoration(
                      hintText: "Vuelva a Ingresar su contraseña",
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class metod {
  Future<User> send() async {
    var newUser = new User(
        email: emailController.text, name: nameController.text, password: password.text, passwordVerify: passwordv.text, type: selectUser);
    debugPrint(newUser.password);
    return newUser;
  }
}

cleanRegister(){
  emailController = new TextEditingController();
  nameController = new TextEditingController();
  password = new TextEditingController();
  passwordv = new TextEditingController();
}
