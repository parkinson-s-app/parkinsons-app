import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;
import 'views/SymptomsForm/symptomsFormQ.dart' show symptomsFormQ;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(debugShowCheckedModeBanner: false, home: symptomsFormQ());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
