import 'dart:io';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsForm extends StatefulWidget {
  @override
  _symptomsForm createState() => _symptomsForm();
}

class _symptomsForm extends State<symptomsForm> {
  File fileMedia;
  MediaSource source;
  int selectedStateRadio = 0;
  int selectedDyskinesiaRadio = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Registro de síntomas'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("¿Cuál es tu estado actual?"),
                RadioListTile(
                  value: 1,
                  groupValue: selectedStateRadio,
                  title: Text("ON"),
                  onChanged: onChangedStateValue,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedStateRadio,
                  title: Text("OFF"),
                  onChanged: onChangedStateValue,
                ),
                Divider(
                  height: 20,
                ),
                Text("¿Presentó alguna disquinesia?"),
                RadioListTile(
                  value: 3,
                  groupValue: selectedDyskinesiaRadio,
                  title: Text("Sí"),
                  onChanged: onChangedDyskinesiaValue,
                ),
                RadioListTile(
                  value: 4,
                  groupValue: selectedDyskinesiaRadio,
                  title: Text("No"),
                  onChanged: onChangedDyskinesiaValue,
                ),
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
                  textColor: Colors.white, onPressed: () {},
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

  Future save() async {}

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
