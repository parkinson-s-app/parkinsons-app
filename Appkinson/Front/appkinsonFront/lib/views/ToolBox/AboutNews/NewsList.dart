/*import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Administrator/item_widget_administrator.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:appkinsonFront/main.dart';


class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}
var news;
var id = 0;
class _ListNewsState extends State<ListNews> {
  final key = GlobalKey<AnimatedListState>();
  //List<AlarmInfo> news;
  DateTime _alarmTime;
  String _alarmTimeString;

  //AlarmInfo alarm;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal,
    appBar: AppBar(
      title: Text("Noticias"),
    ),
    body: Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: key,
            initialItemCount: news.length,
            itemBuilder: (context, index, animation) =>
                buildItem(news[index], index, animation),
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
    news.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    EndPoints().deleteAlarm(index.toString(), token, currentUser['id'].toString());
    final item = news.removeAt(index);

    key.currentState.removeItem(
      index,
          (context, animation) => buildItem(item, index, animation),
    );
  }
}
*/