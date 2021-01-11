import 'package:appkinsonFront/views/Notifications/NotificationPlugin.dart';
import 'package:flutter/material.dart';


class relationRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: SafeArea(
        child: Container(child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Solicitudes de relación",),
          ),
          RaisedButton(onPressed: pushNotification, child: Text("lanzar"), color: Colors.green,),
          Expanded(child:  ListView(
            padding: const EdgeInsets.all(20.0),
            children: _getListings(),
          ),
          )
        ])
        )));
  }
}
Future pushNotification() async {
  relationRequestCount +=1;
  await notificationPlugin.scheduleNotification();
}
Widget buildRelationRrequestMessage(String solicitor, String type){
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
List _listings = new List();
int relationRequestCount = 5;
List<Widget> _getListings() {
  int i = 0;
  List listings = List<Widget>();
  if(relationRequestCount != null){
    for (i = 0; i < relationRequestCount; i++) {
      listings.add(
          buildRelationRrequestMessage("Carlos Andrés Parra", "Cuidador")
      );
      print(relationRequestCount);
  }
}
  return listings;
}