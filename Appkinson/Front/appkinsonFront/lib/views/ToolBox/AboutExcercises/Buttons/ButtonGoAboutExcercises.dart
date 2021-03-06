import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:flutter/material.dart';

import '../ExcercisesList.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoAboutExcercises extends StatelessWidget {
  @override
  var itemsByType;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        RaisedButton(
          shape: CircleBorder(),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

          onPressed: () async {
            ItemToolbox itemToolbox = new ItemToolbox();
            String id = await Utils().getFromToken('id');
            String token = await Utils().getToken();
            itemsByType = await EndPoints().getItemsToolbox(id, token);
            print("Cantidad de items");
            print(itemsByType.length);
            print(itemsByType.toString());
            items.clear();
            for (int i = 0; i < itemsByType.length; i++) {
              itemToolbox = itemsByType[i];
              if (itemToolbox.type.compareTo('EJERCICIO') == 0) {
                items.add(itemToolbox);
              }
            }
            print(items.length);
            RoutesGeneral().toListExcercises(context);
          },
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[50],
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/12-EJERCICIOS.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Ejercicios",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
