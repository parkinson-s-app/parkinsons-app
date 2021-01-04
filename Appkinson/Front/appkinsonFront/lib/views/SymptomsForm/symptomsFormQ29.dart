import 'dart:io';
import '../SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ29 extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

class _symptomsFormQ29 extends State<symptomsFormQ29> {
  File fileMedia;
  MediaSource source;
  int selectedStateRadio = 0;
  int selectedDyskinesiaRadio = 0;


  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: fileMedia == null
                  ? Icon(Icons.play_circle_outline, size: 120)
                  : (source == MediaSource.image
                  ? Image.file(fileMedia)
                  : VideoWidget(fileMedia)),
            ),
            const SizedBox(height: 24),
            RaisedButton(
              child: Text('Capturar video'),
              shape: StadiumBorder(),
              onPressed: () => capture(MediaSource.video),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            const SizedBox(height: 12),
            RaisedButton(
              child: Text('Eliminar video'),
              shape: StadiumBorder(),
              onPressed: () => delete(),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            const SizedBox(height: 12),
            RaisedButton(
              child: Text('Guardar registro'),
              shape: StadiumBorder(),
              //onPressed: () => save(),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () async{
                //endpoint
              },
            ),
          ],
        ),
      ),
    ),
  );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
  Future delete() async {
    setState(() {
      this.fileMedia = null;
    });
  }

  Future save() async{

  }

  void onChangedStateValue(Object value) {
    setState(() {
      selectedStateRadio = value;
    });
  }
  void onChangedDyskinesiaValue(Object value) {
    setState(() {
      selectedDyskinesiaRadio = value;
    });
  }
}