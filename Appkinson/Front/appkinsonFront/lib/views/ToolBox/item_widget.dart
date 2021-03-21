import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:flutter/material.dart';

class ItemToolboxWidgetGeneral extends StatelessWidget {
  final ItemToolbox item;
  final Animation animation;
  final VoidCallback onClicked;

  const ItemToolboxWidgetGeneral({
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
        /* leading: CircleAvatar(
          radius: 32,
          child: Icon(Icons.alarm, color: Colors.amber, size: 45),
        ),*/
        title: Text(item.titulo, style: TextStyle(fontSize: 20)),
        subtitle: Text(item.descripcion),
      ),
    ),
  );
}
