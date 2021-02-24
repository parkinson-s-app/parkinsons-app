import 'package:appkinsonFront/views/Medicines/alarm.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatelessWidget {
  final AlarmInfo item;
  final Animation animation;
  final VoidCallback onClicked;

  const AlarmItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            leading: CircleAvatar(
              radius: 32,
              child: Icon(Icons.alarm, color: Colors.amber, size: 45),
            ),
            title: Text(item.title, style: TextStyle(fontSize: 20)),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red, size: 32),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
