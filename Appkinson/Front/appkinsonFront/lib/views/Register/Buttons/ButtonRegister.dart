import 'package:flutter/material.dart';
import '../../../services/EndPoints.dart';
import '../InputFieldRegister.dart';
import '../InputFieldRegister.dart';
import '../InputFieldRegister.dart';
import '../../../model/User.dart';
import '../InputFieldRegister.dart';
import '../InputFieldRegister.dart';
import '../../Login/LoginPage.dart';
import 'dart:async';

class ButtonRegister extends StatelessWidget {
  /* addUsers(String username, String password) async {
    Map data2 = {'username': username, 'password': password};
    debugPrint(data2.toString());
    http.Response response =
    await http.post('http://192.168.0.16:4000/api/addUsers', body: data2);

    //debugPrint(response.body);

    //data = json.decode(response.body);
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          // addUsers('jorge', '1234');
          var m = new metod();
          var user = await m.send();
          debugPrint(user.email);
          String save = await EndPoints().addUsers(user);
          debugPrint(save);
          if (save == 'Guardado') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => LoginPage()));
          }
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Color.fromRGBO(0, 160, 227, 1),
        textColor: Colors.white,
        child: Text("Registrarse", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
