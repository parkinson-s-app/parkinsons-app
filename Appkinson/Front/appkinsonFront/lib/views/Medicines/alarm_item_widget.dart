import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/Medicines/alarm.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatelessWidget {
  final AlarmAndMedicine item;
  final Animation animation;
  final VoidCallback onClicked;

  const AlarmItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue[100],
        border: Border.all(
          color: Colors.blue
        )
      ),
      child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.alarm, color: Colors.white, size: 50),
            onPressed: (){},
          ),
          ),
          Expanded(
            flex: 2,
            child: _Body(
              medicine: item.idMedicine,
              dose: item.dose,
              time: item.alarmTime,
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child:IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.delete, color: Colors.blue[800], size: 50),
            onPressed: onClicked,
          ), 
           )
        ],
      ),
      )
    );
    /*ScaleTransition(
      scale: animation,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue[100],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          leading: CircleAvatar(
            radius: 32,
            child: Icon(Icons.alarm, color: Colors.white, size: 45),
          ),
          title: Text(item.idMedicine, style: TextStyle(fontSize: 20)),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.blue[800], size: 32),
            onPressed: onClicked,
          ),
        ),
      ),
    );*/
  }
}

class _Body extends StatelessWidget{
  final String medicine;
  final String dose;
  final TimeOfDay time;

  const _Body({
    @required this.medicine,
    @required this.dose,
    @required this.time,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) { 
      return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            medicine + " (" + dose + " tab)",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          Text(
            time.format(context),
            style: const TextStyle(fontSize: 20.0,),
          ),
        ],
      ),
    );
  }
}