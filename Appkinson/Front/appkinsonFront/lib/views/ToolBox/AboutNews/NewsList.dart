import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:flutter/material.dart';

import 'package:appkinsonFront/views/ToolBox/item_widget.dart';

class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}

List<ItemToolbox> news = List<ItemToolbox>();
var id = 0;

class _ListNewsState extends State<ListNews> {
  @override
  final key = GlobalKey<AnimatedListState>();
  //List<AlarmInfo> news;
  DateTime _alarmTime;
  String _alarmTimeString;

  //AlarmInfo alarm;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[100],
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
            /* Container(
              padding: EdgeInsets.all(5),
              child: buildInsertButton(),
            ),*/
          ],
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) =>
      ItemToolboxWidgetGeneral(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );

  Widget buildInsertButton() => RaisedButton(
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.lightGreen,
        ),
        color: Colors.white,
        onPressed: () {
          RoutesAdmin().toFormAddItem(context);
        },
      );

  /* void insertItem(int index, AlarmAndMedicine item) {
    news.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }*/

  void removeItem(int index) {
    EndPoints().deleteAlarm(index.toString(), getToken(), getId());
    final item = news.removeAt(index);

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
