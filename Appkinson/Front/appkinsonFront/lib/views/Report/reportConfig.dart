import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

List<DateTime> picked = [];
String selectedChoice = "";
DateTime selectedDate = DateTime.now();

class ReportConfigPage extends StatefulWidget {
  final int idPatient;

  const ReportConfigPage({Key key, this.idPatient}) : super(key: key);
  @override
  _ReportConfigPageState createState() => _ReportConfigPageState(idPatient);
}

class _ReportConfigPageState extends State<ReportConfigPage> {
  final int idPatient;
  _ReportConfigPageState(this.idPatient);

  List<String> dataList = ["Síntomas", "Ánimo", "Médicamentos", "Destreza"];
  List<String> dataListPeriocity = [
    "Última semana",
    "Último mes",
    "Últimos tres meses",
    "Últimos dos meses",
    //"Último año"
  ];

  void getPeriocity(String periocity) {
    if (picked.isNotEmpty) {
      picked.clear();
    }
    var now = DateTime.now();
    if (periocity == "Última semana") {
      var lastDate = new DateTime(now.year, now.month, now.day - 7);
      picked.add(lastDate);
    }
    if (periocity == "Último mes") {
      picked.add(new DateTime(now.year, now.month - 1, now.day));
    }
    if (periocity == "Últimos dos meses") {
      picked.add(new DateTime(now.year, now.month - 2, now.day));
    }
    if (periocity == "Últimos tres meses") {
      picked.add(new DateTime(now.year, now.month - 3, now.day));
    }
    if (periocity == "Último año") {
      picked.add(new DateTime(now.year - 1, now.month, now.day));
    }
    picked.add(now);
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
            title: Text("Periodicidad"),
            content: MultiSelectChipOne(dataListPeriocity),
            actions: <Widget>[
              FlatButton(
                  child: Text("Aceptar"),
                  onPressed: () {
                    getPeriocity(selectedChoice);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  _openPopup(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            content: Text("Escoge una fecha para generar los reportes"),
            actions: <Widget>[
              FlatButton(
                child: Text("Aceptar"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración del Reporte"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*Container(
              width: 300,
              height: 60,
              child: FlatButton(
                child: Text("Datos"),
                color: Colors.grey[350],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                onPressed: () => _showReportDialog(),
              ),
            ),
            Divider(
              thickness: 1,
            ),*/
            Text(selecteddataList.join(" , ")),
            Padding(
              padding: EdgeInsets.all(30.0),
            ),
            Text(
              "Intervalo de Tiempo: ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 290,
              height: 60,
              child: FlatButton(
                child: Text("Periodicidad"),
                color: Colors.blueAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                onPressed: () => _showReportDialogPeriocity(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 290,
              height: 60,
              child: FlatButton(
                child: Text("Escoger fecha"),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                onPressed: () {
                   showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime(DateTime.now().year + 1))
                    .then((value) {
                        selectedDate = value;
                  });
                  print("PRUEBAAA NUEVAAAAA");
                  print(selectedDate);
                  if(picked.isNotEmpty){ picked.clear();}
                  picked.add(new DateTime(selectedDate.year, selectedDate.month , selectedDate.day, 00 , 00 , 00));
                  picked.add(new DateTime(selectedDate.year, selectedDate.month , selectedDate.day, 23 , 59 , 59));
                },
              ),
            ),
            /* Container(
              width: 290,
              height: 60,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Colors.grey[350],
                  onPressed: () async {
                    print("Entraaa");
                    if (picked.isNotEmpty) {
                      picked.clear();
                    }
                    picked = await DateRangePicker.showDatePicker(
                        context: context,
                        initialFirstDate: new DateTime.now(),
                        initialLastDate:
                            (new DateTime.now()).add(new Duration(days: 7)),
                        firstDate: new DateTime(2015),
                        lastDate: new DateTime(DateTime.now().year + 2));
                    print(picked[0]);
                    print(picked[1]);
                  },
                  child: new Text("Seleccionar fechas")),
            ),*/
            Padding(
              padding: EdgeInsets.all(100.0),
            ),
            Container(
              width: 290,
              height: 60,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                onPressed: () {
                  print(picked[0]);
                  print(picked[1]);
                  if (picked.isNotEmpty) {
                    RoutesDoctor().toListReportPage(context, idPatient, picked);
                  } 
                  if(picked.isEmpty){
                    print("ENTRA");
                  }
                },
                child: Text("Generar Reporte"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
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
