import 'package:flutter/material.dart';

class EndPoints {
  addUsers(String username, String password) async {
    Map data2 = {'username': username, 'password': password};
    debugPrint(data2.toString());
    //http.Response response =
    //await http.post('http://192.168.0.16:4000/api/addUsers', body: data2);

    //debugPrint(response.body);

    //data = json.decode(response.body);
  }
}
