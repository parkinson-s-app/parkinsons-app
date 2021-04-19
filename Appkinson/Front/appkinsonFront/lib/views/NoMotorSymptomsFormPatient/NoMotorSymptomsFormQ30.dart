import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:flutter/material.dart';
import '../../model/NoMotorSymptomsForm.dart';
import '../../services/EndPoints.dart';
import 'NoMotorSymptomsFormQ1.dart';
import 'NoMotorSymptomsFormQ2.dart';
import 'NoMotorSymptomsFormQ3.dart';
import 'NoMotorSymptomsFormQ4.dart';
import 'NoMotorSymptomsFormQ5.dart';
import 'NoMotorSymptomsFormQ6.dart';
import 'NoMotorSymptomsFormQ7.dart';
import 'NoMotorSymptomsFormQ8.dart';
import 'NoMotorSymptomsFormQ9.dart';
import 'NoMotorSymptomsFormQ10.dart';
import 'NoMotorSymptomsFormQ11.dart';
import 'NoMotorSymptomsFormQ12.dart';
import 'NoMotorSymptomsFormQ13.dart';
import 'NoMotorSymptomsFormQ14.dart';
import 'NoMotorSymptomsFormQ15.dart';
import 'NoMotorSymptomsFormQ16.dart';
import 'NoMotorSymptomsFormQ17.dart';
import 'NoMotorSymptomsFormQ18.dart';
import 'NoMotorSymptomsFormQ19.dart';
import 'NoMotorSymptomsFormQ20.dart';
import 'NoMotorSymptomsFormQ21.dart';
import 'NoMotorSymptomsFormQ22.dart';
import 'NoMotorSymptomsFormQ23.dart';
import 'NoMotorSymptomsFormQ24.dart';
import 'NoMotorSymptomsFormQ25.dart';
import 'NoMotorSymptomsFormQ26.dart';
import 'NoMotorSymptomsFormQ27.dart';
import 'NoMotorSymptomsFormQ28.dart';
import 'NoMotorSymptomsFormQ29.dart';

class NoMotorSymptomsFormQ30 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ30 createState() => _NoMotorSymptomsFormQ30();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character;
int selectedStateRadioQ30 = 0;

class _NoMotorSymptomsFormQ30 extends State<NoMotorSymptomsFormQ30> {
  void initState() {
    super.initState();
    _character = SigningCharacter.Nada;
    selectedStateRadioQ30 = 0;
  }
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
                "Creer que le pasan cosas que otras personas le dicen que no son verdad.",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(children: <Widget>[
              Divider(
                height: 80,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Si',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ30 = 1;
                  });
                },
              ),
              Divider(
                height: 100,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'No',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ30 = 2;
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
                  NoMotorSymptomsForm patientForm = new NoMotorSymptomsForm();
                  patientForm.q1 = BringAnswer1().send();
                  patientForm.q2 = BringAnswer2().send();
                  patientForm.q3 = BringAnswer3().send();
                  patientForm.q4 = BringAnswer4().send();
                  patientForm.q5 = BringAnswer5().send();
                  patientForm.q6 = BringAnswer6().send();
                  patientForm.q7 = BringAnswer7().send();
                  patientForm.q8 = BringAnswer8().send();
                  patientForm.q9 = BringAnswer9().send();
                  patientForm.q10 = BringAnswer10().send();
                  patientForm.q11 = BringAnswer11().send();
                  patientForm.q12 = BringAnswer12().send();
                  patientForm.q13 = BringAnswer13().send();
                  patientForm.q14 = BringAnswer14().send();
                  patientForm.q15 = BringAnswer15().send();
                  patientForm.q16 = BringAnswer16().send();
                  patientForm.q17 = BringAnswer17().send();
                  patientForm.q18 = BringAnswer18().send();
                  patientForm.q19 = BringAnswer19().send();
                  patientForm.q20 = BringAnswer20().send();
                  patientForm.q21 = BringAnswer21().send();
                  patientForm.q22 = BringAnswer22().send();
                  patientForm.q23 = BringAnswer23().send();
                  patientForm.q24 = BringAnswer24().send();
                  patientForm.q25 = BringAnswer25().send();
                  patientForm.q26 = BringAnswer26().send();
                  patientForm.q27 = BringAnswer27().send();
                  patientForm.q28 = BringAnswer28().send();
                  patientForm.q29 = BringAnswer29().send();
                  patientForm.q30 = BringAnswer30().send();
                  patientForm.date = new DateTime.now();
                  debugPrint("formulario llenado");
                  String id = await Utils().getFromToken('id');
                  String token = await Utils().getToken();
                  var savedEmotional = await EndPoints().registerNoMotorSymptomsForm(patientForm, id, token);

                  //var savedEmotional2 = await EndPoints().getNoMotorSymptomsForm( id, token, new DateTime.utc(2021, 02, 20) , patientForm.date);
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

class BringAnswer30 {
  int send() {
    return selectedStateRadioQ30;
  }
}
