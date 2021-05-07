import 'package:flutter/material.dart';

class EmotionalFormQ0 extends StatefulWidget {
  @override
  _EmotionalFormQ0 createState() => _EmotionalFormQ0();
}


class _EmotionalFormQ0 extends State<EmotionalFormQ0> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.3
                ),
                padding: EdgeInsets.only(
                  top: size.height * 0.05
                ),
                height: 430,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)
                  )
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0
                      ),
                      child: Text(
                      "¿Durante la última semana qué tan frecuente presentó alguno de los siguientes problemas?",
                      textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "Ralewaybold",
                          color: Colors.black
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              "assets/images/desplazarse.png",
                              height: size.height * 0.3,
                              fit: BoxFit.scaleDown
                            )
                          )
                        ],
                      ),
                    )
                  ]
                )
              ),
              Padding(
                padding: const EdgeInsets.all(
                  12.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Puedes completar de forma periódica (semanal) las siguientes dos preguntas para evaluar de forma inicial tus síntomas del estado de ánimo. Al final de cada registro conocerás el resultado y en el apartado de “Reportes” podrás ver la evolución de tus resultados a través del tiempo.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Ralewaybold",
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              )
            ]
          )
        ],
      )
    );

  }
}