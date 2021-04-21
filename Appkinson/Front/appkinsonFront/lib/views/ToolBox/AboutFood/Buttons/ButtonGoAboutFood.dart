import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:flutter/material.dart';

import '../FoodList.dart';

//import '../../Register/RegisterPage.dart';
var itemsByType;

class ButtonGoAboutFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
          onPressed: () async {
            ItemToolbox itemToolbox = new ItemToolbox();
            String token = await Utils().getToken();
            String id = await Utils().getFromToken('id');
            itemsByType = await EndPoints().getItemsToolbox(id, token);
            print(itemsByType.length);
            for (int i = 0; i < itemsByType.length; i++) {
              itemToolbox = itemsByType[i];
              print(itemToolbox.type.compareTo('COMIDA'));
              if (itemToolbox.type.compareTo('COMIDA') == 0) {
                food.add(itemToolbox);
              }
            }
            print(food.length);
            RoutesGeneral().toListFood(context);
          },
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[50],
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/food.png",
            height: size.height * 0.08,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Comidas",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
