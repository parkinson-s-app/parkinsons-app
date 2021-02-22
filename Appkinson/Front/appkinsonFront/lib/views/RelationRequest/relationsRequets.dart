import 'package:appkinsonFront/views/RelationRequest/dataRequest.dart';
import 'package:appkinsonFront/views/RelationRequest/relationRequestPlugin.dart';
import 'package:appkinsonFront/views/RelationRequest/request.dart';
import 'package:appkinsonFront/views/RelationRequest/request_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RelationsRequest extends StatefulWidget {
  @override
  _RelationsRequestState createState() => _RelationsRequestState();
}

class _RelationsRequestState extends State<RelationsRequest> {
  final key = GlobalKey<AnimatedListState>();
  //final items = List.from(Data.relations);
  final items = getListRelationsRequest();
  //List<AlarmInfo> items;
  DateTime _alarmTime;
  String _alarmTimeString;
  //AlarmInfo alarm;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text("Solicitudes de relación"),
          actions:<Widget> [
            new IconButton(
                icon: Icon(Icons.settings),
                color: Colors.black45,
                onPressed: () {
                  //onSaveAlarm();
                  //deleteAlarm(alarm.id);
                }),
          ],
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
          ],
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) =>
      RequestItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
        onClicked2: () => removeItem2(index),
      );

  /*void insertItem(int index, RelationRequest item, String _alarmTimeString) {
    RelationRequest alarm;
    //alarm.title = "Hola";
   // alarm.title = _alarmTimeString;
    item.message = _alarmTimeString;
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }*/

  void removeItem(int index) {
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
  void removeItem2(int index) {
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
          (context, animation) => buildItem(item, index, animation),
    );
  }
}
