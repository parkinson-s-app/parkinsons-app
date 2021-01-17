import 'dart:convert';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Notifications/NotificationPlugin.dart';
import 'package:appkinsonFront/views/RelationRequest/relationRequestPlugin.dart';
import 'package:flutter/material.dart';

class RelationRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: SafeArea(
        child: Container(child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Solicitudes de relación",),
          ),
          Expanded(child:  ListView(
            padding: const EdgeInsets.all(20.0),
            children: getListRelationsRequest(),
          ),
          )
        ])
        )));
  }
}
Widget buildRelationRequestMessage(String solicitor, String type){
  return Container(
      width: 50.0,
      height: 100.0,
      child: new Stack(
        children: <Widget> [
          Text(solicitor + " quiere ser tu " + type),
          Positioned(
            top: 20,
            child: RaisedButton(onPressed: null, child: Text("Aceptar"), color: Colors.green,),
          ),
          Positioned(
            top: 20,
            right: 60,
            child: RaisedButton(onPressed: null, child: Text("Cancelar"), color: Colors.redAccent),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      )
  );
}
List<Widget> convertRelationsRequest(){

   List<Widget> relationsRequest;
   relationsRequest = getListRelationsRequest();
   print("HEREEEEE");
   print(relationsRequest.length);
   return relationsRequest == null ? [] : relationsRequest;
}