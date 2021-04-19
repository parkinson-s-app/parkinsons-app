import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
   

List<DateTime> picked = [];
String selectedChoice = "";
class ReportConfigPage extends StatefulWidget {

  final int idPatient;

  const ReportConfigPage({Key key, this.idPatient}) : super(key: key);
  @override
  _ReportConfigPageState createState() => _ReportConfigPageState(idPatient);
}

class _ReportConfigPageState extends State<ReportConfigPage> {
  final int idPatient;
  _ReportConfigPageState(this.idPatient);


  List<String> dataList = [
    "Síntomas",
    "Ánimo",
    "Médicamentos",
    "Destreza"
  ];
  List<String> dataListPeriocity = [
    "Última semana",
    "Último mes",
    "Ultimos tres meses",
    "Últimos seis meses",
    "Último año"
  ];

  

  void getPeriocity(String periocity){
    if(picked.isNotEmpty){
       picked.clear();
    }
    print("Hola");
    var now = DateTime.now(); 
    picked.add(now);
    if(periocity == "Última semana"){
      var lastDate = new DateTime(now.year , now.month , now.day - 7);
      picked.add(lastDate);
    }
     if(periocity == "Último mes"){
       picked.add(new DateTime(now.year , now.month -1 , now.day)); 
    }
     if(periocity == "Ultimos tres meses"){
       picked.add(new DateTime(now.year , now.month -3, now.day)); 
    }
     if(periocity == "Últimos seis meses"){
       picked.add(new DateTime(now.year , now.month -6, now.day)); 
    }
     if(periocity == "Último año"){
       picked.add(new DateTime(now.year -1, now.month , now.day)); 
    }
    print(picked[0]);
    print(picked[1]);
  }


  List<String> selecteddataList = List();

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Elige los datos que deseas analizar"),
            content: MultiSelectChip(
              dataList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selecteddataList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Aceptar"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  _showReportDialogPeriocity() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Periocidad"),
            content: MultiSelectChipOne(dataListPeriocity),
            actions: <Widget>[
              FlatButton(
                child: Text("Aceptar"),
                onPressed: () {
                  getPeriocity(selectedChoice);
                  Navigator.of(context).pop();
                }
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración del reporte"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Datos"),
              onPressed: () => _showReportDialog(),
            ),
            Text(selecteddataList.join(" , ")),
            Padding(
              padding: EdgeInsets.all(30.0),
            ),
            Text("Intervalo de tiempo"),
            RaisedButton(
              child: Text("Periocidad"),
              onPressed: () => _showReportDialogPeriocity(),
            ),
            RaisedButton(
            //color: Colors.deepOrangeAccent,
            onPressed: () async {
              print("Entraaa");
              if(picked.isNotEmpty){
                picked.clear();
              }
               picked = await DateRangePicker.showDatePicker(
                  context: context,
                  initialFirstDate: new DateTime.now(),
                  initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                  firstDate: new DateTime(2015),
                  lastDate: new DateTime(DateTime.now().year + 2)
              );
              print(picked[0]);
              print(picked[1]);
            },
            child: new Text("Seleccionar fechas")
            ),
            Padding(
              padding: EdgeInsets.all(100.0),
            ),
            FlatButton(onPressed: (){
              if(!picked.isEmpty){
                RoutesDoctor().toListReportPage(context, idPatient, picked);
              }
              else{
                print("Agregar pop up de que debe seleccionar fechas");
              }
              
            }, child: Text("Generar reporte"), color: Colors.blueAccent,
              textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}



class MultiSelectChipOne extends StatefulWidget {
  final List<String> reportList;
  MultiSelectChipOne(this.reportList);
  @override
  _MultiSelectChipStateOne createState() => _MultiSelectChipStateOne();
}
class _MultiSelectChipStateOne extends State<MultiSelectChipOne> {
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });    return choices;
  }  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}


class MultiSelectChip extends StatefulWidget {
  final List<String> dataList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.dataList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
// String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.dataList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}