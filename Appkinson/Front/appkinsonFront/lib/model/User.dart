import 'dart:io';
//Modelo usado para manejar los datos de perfil correspondientes a un usuario
class User {
  String email;
  String name;
  String password;
  String passwordVerify;
  String type;
  File photo;
  int id;
  User({
        this.email,
        this.password,
        this.passwordVerify,
        this.type,
        this.name,
        this.photo,
        this.id
        });
}
