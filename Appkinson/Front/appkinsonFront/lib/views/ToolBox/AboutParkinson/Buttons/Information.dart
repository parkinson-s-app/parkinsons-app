import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: ListView(children: [
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Sobre Parkinson",
                style: TextStyle(fontSize: 20.0, color: Colors.blue[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "El párkinson es una enfermedad producida por un proceso neurodegenerativo multisistémico que afecta al sistema nervioso central lo que provoca la aparición de síntomas motores y no motores. Es crónica y afecta de diferente manera a cada persona que la padece, la evolución puede ser muy lenta en algunos pacientes y en otros puede evolucionar más rápidamente. No es una enfermedad fatal, lo que significa que el afectado no va a fallecer a causa del párkinson.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Los síntomas motores más frecuentes son el temblor, la rigidez, la lentitud de movimientos y la inestabilidad postural, entre otros. Además de la alteración motora, otras regiones del sistema nervioso y otros neurotransmisores diferentes a la dopamina están también involucrados en la enfermedad, añadiendo otros síntomas diversos a los síntomas motores típicos, conocidos como síntomas no motores. Con frecuencia aparecen años antes que los síntomas motores, se los conoce como “síntomas premotores”. Los más conocidos son: depresión, reducción del olfato, estreñimiento y trastorno de conducta del sueño REM (ensoñaciones muy vívidas).",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
              onPressed: () async {
                const url =
                    'https://www.parkinsonmadrid.org/el-parkinson/el-parkinson-definicion/';
                await launch(url);
              },
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Más Información", style: TextStyle(fontSize: 13)),
            ),
          ])
        ]));
  }
}
