import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:flutter/material.dart';
import '../../model/EmotionalForm.dart';
import '../../services/EndPoints.dart';
import 'EmotionalFormQ1.dart';

class EmotionalFormQ2 extends StatefulWidget {
  final int idPatient;

  EmotionalFormQ2({Key key, this.idPatient}) : super(key: key);
  @override
  _EmotionalFormQ2 createState() => _EmotionalFormQ2(this.idPatient);
}

enum SigningCharacter2 { Cero, Uno, Dos, Tres, Nada }
SigningCharacter2 _character2;
int selectedStateRadioQ2;

class _EmotionalFormQ2 extends State<EmotionalFormQ2> {
  final int idPatient;
  _EmotionalFormQ2(this.idPatient);
  void initState() {
    super.initState();
    //_character2 = SigningCharacter2.Nada;
    //selectedStateRadioQ1 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[350],
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                " Se ha sentido decaído(a), deprimido(a) o sin esperanzas",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(children: <Widget>[
              Divider(
                height: 40,
              ),
              RadioListTile<SigningCharacter2>(
                title: const Text(
                  'Ningún día',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter2.Cero,
                groupValue: _character2,
                onChanged: (SigningCharacter2 value) {
                  setState(() {
                    _character2 = value;
                    selectedStateRadioQ2 = 0;
                  });
                },
              ),
              Divider(
                height: 40,
              ),
              RadioListTile<SigningCharacter2>(
                title: const Text(
                  'Varios días',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter2.Uno,
                groupValue: _character2,
                onChanged: (SigningCharacter2 value) {
                  setState(() {
                    _character2 = value;
                    selectedStateRadioQ2 = 1;
                  });
                },
              ),
              Divider(
                height: 40,
              ),
              RadioListTile<SigningCharacter2>(
                title: const Text(
                  'Más de la mitad de los días',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter2.Dos,
                groupValue: _character2,
                onChanged: (SigningCharacter2 value) {
                  setState(() {
                    _character2 = value;
                    selectedStateRadioQ2 = 2;
                  });
                },
              ),
              Divider(
                height: 40,
              ),
              RadioListTile<SigningCharacter2>(
                title: const Text(
                  'Casi todos los días',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter2.Tres,
                groupValue: _character2,
                onChanged: (SigningCharacter2 value) {
                  setState(() {
                    _character2 = value;
                    selectedStateRadioQ2 = 3;
                  });
                },
              ),
              Divider(
                height: 40,
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
                  var savedEmotional = await EndPoints()
                      .registerEmotionalForm(patientForm, idPatient, token);

                  //var savedEmotional2 = await EndPoints().getEmotionalForm( id, token, new DateTime.utc(2021, 02, 20) , patientForm.date);
                  debugPrint("formulario enviado");
                  RestartListTile2().setTile2();
                  RestartListTile().setTile1();
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
class RestartListTile2 {
  void setTile2(){
    _character2 = SigningCharacter2.Nada;
  }
}