import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:flutter/material.dart';

class ButtonGoReporter extends StatelessWidget {
  int idPatient;

  ButtonGoReporter({@required this.idPatient});

  @override
  Widget build(BuildContext context) {
    print("id ppp" + this.idPatient.toString());
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        shape: CircleBorder(),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String type = await Utils().getFromToken("type");
          if (type == "Paciente") {
            print("object");
            var aux = await Utils().getFromToken("id");
            this.idPatient = int.parse(aux);
            print("entra pat" + this.idPatient.toString());
            //RoutesDoctor().toReportConfigPage(context, idPatient);
          }
          RoutesDoctor().toReportConfigPage(context, idPatient);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/14-LISTA.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
