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
                "La enfermedad de Parkinson es una condición neurodegenerativa que afecta al sistema nervioso central, provocando síntomas como lentitud, rigidez, temblor y alteraciones en la marcha.  Está causado por un proceso progresivo de deterioro y muerte de las neuronas que producen dopamina, un neurotransmisor involucrado en la movilidad y el adecuado funcionamiento de las capacidades motoras, así como en la expresión de las emociones. Debido a la complejidad de la enfermedad, se presentan también múltiples síntomas no motores, como trastornos del ánimo, ansiedad, depresión, alteraciones del sueño, disminución del olfato, estreñimiento, entre otros. Aunque aun no se conoce una cura, el tratamiento farmacológico se basa en suplir los efectos de la dopamina faltante en el cerebro, mejorando los síntomas y la calidad de vida de los pacientes. ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "A medida que la enfermedad evoluciona, el tiempo del efecto de algunos medicamentos comienza a acortarse, y los pacientes empiezan a experimentar fluctuaciones de su estado motor, relacionadas con el tiempo que ha pasado después de cada dosis del medicamento. De esta forma, en un mismo día, y en cuestión de horas, los pacientes pasan de estar bajo los efectos benéficos de la medicación, en lo que se denomina estado ON, en el cual  existe una mejor movilidad y velocidad de los movimientos y una disminución del temblor, a tornarse lentos, rígidos y algunos con mayor temblor, en lo que se denomina estado OFF, que significa que el medicamento ha perdido todo su efecto. Adicionalmente, con la progresión de la enfermedad, algunos pacientes experimentan disquinesias, que son movimientos exagerados que se producen con el efecto de la medicación, debido a la pérdida cada vez mayor de las neuronas dopaminérgicas. Identificar todos estos cambios tanto motores, como no motores, es de vital importancia para optimizar el tratamiento de la enfermedad. ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
              ),
            ),
            /*FlatButton(
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
            ),*/
          ])
        ]));
  }
}
