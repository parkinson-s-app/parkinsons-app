
import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';


import '../NewsList.dart';


class ButtonGoAboutNews extends StatelessWidget {
  @override
  List<ItemToolbox> itemsByType = [];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: FlatButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          ItemToolbox itemToolbox = new ItemToolbox();
          itemsByType = await EndPoints().getItemsToolbox(currentUser['id'].toString(), token);
          print(itemsByType.length);
          for(int i = 0; i<itemsByType.length; i++){
            itemToolbox = itemsByType[i];
            print(itemToolbox.type.compareTo('NOTICIA'));
            if(itemToolbox.type.compareTo('NOTICIA') == 0) {
              print("No entra");
              news.add(itemToolbox);
            }
          }

          RoutesGeneral().toListExcercises(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/news.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
