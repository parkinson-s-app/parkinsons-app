import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

String enlace = "https://www.fleni.org.ar/novedades/parkinson-ejercicios-para-todos-los-dias/";

bool isExercise;

class ItemToolboxWidgetGeneral extends StatelessWidget {
  final ItemToolbox item;
  final Animation animation;
  final VoidCallback onClicked;

  const ItemToolboxWidgetGeneral({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) { 
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: Colors.blue
        )
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              _tipe(item.type),
              fit: BoxFit.scaleDown,
            ),
          ),
          Expanded(
            flex: 3,
            child: _Body(
              title: item.titulo,
              description: item.descripcion,
              link: item.enlace,
            ),
          ),
        ],
      ),
      )
    );
    /*ScaleTransition(
    scale: animation,
    child: Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: Colors.blue
        )
      ),
      child: ListTile(
        onTap:() {
          _launchURL(item.enlace);
        },
        leading: Image.asset(
            _tipe(item.type),
          ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        /* leading: CircleAvatar(
          radius: 32,
          child: Icon(Icons.alarm, color: Colors.amber, size: 45),
        ),*/
        title: Text(item.titulo, style: TextStyle(fontSize: 20)),
      ),
    ),
  );*/
  }
}

class _Body extends StatelessWidget{
  final String title;
  final String description;
  final String link;

  const _Body({
    @required this.title,
    @required this.description,
    @required this.link,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) { 
      return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          Text(
            description,
            style: const TextStyle(fontSize: 15.0,),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          InkWell(
            child: Text(
              link,
              style: const TextStyle(color: Colors.blue),
            ),
            onTap: () => _launchURL(link),
          )
        ],
      ),
    );
  }
}

String _tipe(String tipo){
  if(tipo.compareTo('EJERCICIO') == 0){
    return "assets/images/12-EJERCICIOS.png";
  }
  if(tipo.compareTo('ALIMENTACION') == 0){
    return "assets/images/8-COMIDA.png";
  }
  if(tipo.compareTo('NOTICIA') == 0){
    return "assets/images/10-NOTICIAS.png";
  }
  return " ";
}

void _launchURL(String enlace) async{
  if(await canLaunch(enlace)){
    await launch(enlace);
  }else{
      throw 'no se pudo cargar el enlace';
  }
}