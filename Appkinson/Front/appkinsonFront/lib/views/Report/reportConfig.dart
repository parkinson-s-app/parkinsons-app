import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class ReportConfigPage extends StatefulWidget {

  @override
  _ReportConfigPageState createState() => _ReportConfigPageState();
}

class _ReportConfigPageState extends State<ReportConfigPage> {
  List<String> dataList = [
    "Síntomas",
    "Ánimo",
    "Médicamentos",
    "Destreza"
  ];
  List<String> dataListPeriocity = [
    "Última semana",
    "Último mes",
    "últimos tres meses",
    "Últimos seis meses",
    "Último año"
  ];


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
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  _showIntervalDates(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return new FlatButton(
              color: Colors.deepOrangeAccent,
              onPressed: () async {
                final List<DateTime> picked = await DateRangePicker.showDatePicker(
                    context: context,
                    initialFirstDate: new DateTime.now(),
                    initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                    firstDate: new DateTime(2015),
                    lastDate: new DateTime(DateTime.now().year + 2)
                );
                if (picked != null && picked.length == 2) {
                  print(picked);
                }
              },
              child: new Text("Seleccionar fechas")
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
              final List<DateTime> picked = await DateRangePicker.showDatePicker(
                  context: context,
                  initialFirstDate: new DateTime.now(),
                  initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                  firstDate: new DateTime(2015),
                  lastDate: new DateTime(DateTime.now().year + 2)
              );
              if (picked != null && picked.length == 2) {
                print(picked);
              }
            },
            child: new Text("Seleccionar fechas")
            ),
            Padding(
              padding: EdgeInsets.all(100.0),
            ),
            FlatButton(onPressed: (){
              RoutesDoctor().toListReportPage(context);
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
  String selectedChoice = "";  // this function will build and return the choice list
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