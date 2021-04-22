import 'package:flutter/material.dart';
// import 'package:aplicacion_alimentos/src/infoperfil.dart';

class Recomendados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 20.0, right: 20.0, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Buscador",
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Alimentos recomendados',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
              // onTap: () => Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => InfoPerfil())),
              child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: EdgeInsets.all(15),
            elevation: 10,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ClipRRect(
              child: Column(
                children: [
                  Image.network(
                    'https://placeimg.com/640/480/any',
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Montañas'),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
