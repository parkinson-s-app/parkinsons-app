import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Acerca de Nosotros",
          style: TextStyle(fontSize: 20.0, color: Colors.blue[900]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Somos un grupo conformado por estudiantes y profesores expertos en " +
              "construccion de software y neurologia. Estamos comprometidos a mejorar la " +
              "calidad de vida de pacientes diagnosticados con la enfermedad de " +
              "parkinson. Si existe algun problema al usar esta aplicacion puede " +
              "contactarnos por medio de este correo vera_l@javeriana.edu.co.",
          style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
        ),
      ),
    ]))));
  }
}