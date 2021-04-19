import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Administrator/item_widget_administrator.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:appkinsonFront/main.dart';


class ListItemsAdministrator extends StatefulWidget {
  @override
  _ListItemsAdministratorState createState() => _ListItemsAdministratorState();
}
var items;
var id = 0;
class _ListItemsAdministratorState extends State<ListItemsAdministrator> {
  final key = GlobalKey<AnimatedListState>();
  //List<AlarmInfo> items;
  DateTime _alarmTime;
  String _alarmTimeString;

  //AlarmInfo alarm;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal,
    appBar: AppBar(
      title: Text("Items"),
    ),
    body: Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: key,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) =>
                buildItem(items[index], index, animation),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: buildInsertButton(),
        ),
      ],
    ),
  );

  Widget buildItem(item, int index, Animation<double> animation) =>
      ItemToolboxWidgetAdministrator(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );


  Widget buildInsertButton() => RaisedButton(
    child: Icon(Icons.add, size: 50, color: Colors.lightGreen,),
    color: Colors.white,
    onPressed: () {
      RoutesAdmin().toFormAddItem(context);
    },
  );

  void insertItem(int index, AlarmAndMedicine item) {
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    String id = getId();
    String token = getToken();
    EndPoints().deleteAlarm(index.toString(), token, id);
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
          (context, animation) => buildItem(item, index, animation),
    );
  }
}

getId() async {
  String id = await Utils().getFromToken('id');
  return id;
}

getToken() async {
  String token = await Utils().getToken();
  return token;
}