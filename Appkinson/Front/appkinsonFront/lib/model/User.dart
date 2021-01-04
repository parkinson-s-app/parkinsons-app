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