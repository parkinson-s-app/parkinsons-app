import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Acerca de Nosotros",
                  style: TextStyle(
                    fontSize: 20.0, 
                    color: Colors.blue[900]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Somos un grupo conformado por estudiantes y profesores expertos en " +
                      "construccion de software y neurología. Estamos comprometidos a mejorar la " +
                      "calidad de vida de pacientes diagnosticados con la enfermedad de " +
                      "Parkinson. Si existe algun problema al usar esta aplicación puede " +
                      "contactarnos por medio de este correo vera_l@javeriana.edu.co.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15.0, 
                    color: Colors.grey[600]
                  ),
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
