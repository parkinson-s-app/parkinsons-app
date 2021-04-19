import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:flutter/material.dart';
import '../../model/EmotionalForm.dart';
import '../../services/EndPoints.dart';
import 'EmotionalFormQ1.dart';

class EmotionalFormQ2 extends StatefulWidget {
  @override
  _EmotionalFormQ2 createState() => _EmotionalFormQ2();
}

enum SigningCharacter { Si, No }
SigningCharacter _character;
int selectedStateRadioQ2 = -1;

class _EmotionalFormQ2 extends State<EmotionalFormQ2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white60,
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                " Se ha sentido decaído(a), deprimido(a) o sin esperanzas",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(children: <Widget>[
              Divider(
                height: 50,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Ningún día',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ2 = 0;
                  });
                },
              ),
              Divider(
                height: 50,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Varios días',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ2 = 1;
                  });
                },
              ),
              Divider(
                height: 50,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Más de la mitad de los días',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ2 = 2;
                  });
                },
              ),
              Divider(
                height: 50,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Casi todos los días',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ2 = 3;
                  });
                },
              ),
              Divider(
                height: 50,
              ),
              RaisedButton(
                child: Text("Guardar registro", style: TextStyle(fontSize: 20)),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 50),
                //onPressed: () => save(),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  EmotionalForm patientForm = new EmotionalForm();
                  patientForm.q1 = BringAnswer1().send();
                  patientForm.q2 = BringAnswer2().send();
                  patientForm.date = new DateTime.now();
                  debugPrint("formulario llenado");
                  String id = await Utils().getFromToken('id');
                  String token = await Utils().getToken();
                  var savedEmotional = await EndPoints().registerEmotionalForm(patientForm, id, token);

                  //var savedEmotional2 = await EndPoints().getEmotionalForm( id, token, new DateTime.utc(2021, 02, 20) , patientForm.date);
                  debugPrint("formulario enviado");
                  RoutesGeneral().toPop(context);
                },
              ),
            ]),

            /*Expanded(
            flex: 1,
          */
          ),
        ],
      ),
    );
  }
}

class BringAnswer2 {
  int send() {
    return selectedStateRadioQ2;
  }
}
