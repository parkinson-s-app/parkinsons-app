import 'dart:convert';

import 'dart:io';

class User {
  String email;
  String name;
  String password;
  String type;
  File photo;

  User({this.email, this.password, this.type, this.name, this.photo});
}

List<User> kUsers = <User>[
  User(
      name: 'camilo',
      email: 'camilo@',
      password: 'contraseña',
      type: 'Paciente'
  ),
  User(
      name: 'sebastian',
      email: 'sebastian@',
      password: 'contraseña',
      type: 'Paciente'
  ),
];