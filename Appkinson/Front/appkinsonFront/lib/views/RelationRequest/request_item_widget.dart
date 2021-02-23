import 'package:appkinsonFront/views/RelationRequest/request.dart';
import 'package:flutter/material.dart';

class RequestItemWidget extends StatelessWidget {
  final RelationRequest item;
  final Animation animation;
  final VoidCallback onClicked;
  final VoidCallback onClicked2;

  const RequestItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    @required this.onClicked2,
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
              child: Icon(Icons.account_circle_rounded, color: Colors.lightBlueAccent, size: 45),
            ),
            title: Text(item.message, style: TextStyle(fontSize: 15)),
            trailing: IconButton(
              alignment: Alignment.bottomLeft,
              icon: Icon(Icons.delete, color: Colors.red, size: 32),
              onPressed: onClicked2,
            ),
            subtitle: RaisedButton(
              child: Text("Aceptar solicitud", style: TextStyle(fontSize: 15),),
              textColor: Colors.green,
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
