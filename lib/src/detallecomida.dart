import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplicacion_alimentos/main.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class DetalleComida extends StatefulWidget {
  final String idcomida;
  final List list;
  final int index;

  const DetalleComida({Key key, this.idcomida, this.list, this.index})
      : super(key: key);
  @override
  _DetalleComidaState createState() => _DetalleComidaState();
}

class _DetalleComidaState extends State<DetalleComida> {
  String url2 = 'http://gestionaproyecto.com/phpappalimentos/getReceta.php';

  Future<List> getReceta() async {
    final response = await http.post(Uri.parse(url2), body: {
      "idcomida": widget.idcomida,
    });
    var datauser = json.decode(response.body);

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(),
        child: FloatingActionButton(
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onPressed: () {},
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Column(children: <Widget>[
              AppBar(
                backgroundColor: Color.fromRGBO(46, 12, 21, 20),
                title: Text(
                  'Receta',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage(
                          widget.list[widget.index]['rutaimagencomida'])),
                  gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(46, 12, 21, 20),
                        Color.fromRGBO(46, 12, 21, 10)
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Center(
                  child: Text(
                "${widget.list[widget.index]['nombrecomida']}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Text(
                    "${widget.list[widget.index]['descripcioncomida']}",
                    style: TextStyle(fontSize: 20),
                  )
                ]),
              ),
            ]),
            Expanded(
              child: new FutureBuilder<List>(
                  future: getReceta(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? new InfoComida(
                            list: snapshot.data,
                            index: widget.index,
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoComida extends StatefulWidget {
  final List list;
  final int index;

  InfoComida({Key key, this.list, this.index}) : super(key: key);
  @override
  _InfoComidaState createState() => _InfoComidaState();
}

class _InfoComidaState extends State<InfoComida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  "Ingredientes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              child: Expanded(
                  child: new ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: widget.list == null ? 0 : widget.list.length,
                      itemBuilder: (context, i) {
                        return new Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  "- " + widget.list[i]["nombrealimento"],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
