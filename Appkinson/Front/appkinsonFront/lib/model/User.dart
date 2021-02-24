import 'dart:io';

class User {
  String email;
  String name;
  String password;
  String passwordVerify;
  String type;
  File photo;

  User({this.email, this.password, this.passwordVerify, this.type, this.name, this.photo});
}
