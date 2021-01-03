import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;
import 'views/SymptomsForm/symptomsForm.dart' show symptomsForm;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: symptomsForm());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
