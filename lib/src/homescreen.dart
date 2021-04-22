import 'package:aplicacion_alimentos/src/detallecomida.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplicacion_alimentos/main.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  final String idusuario;

  const Homescreen({Key key, this.idusuario}) : super(key: key);
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  SharedPreferences sharedPreferences;
  String idusuariofinal;

  void initState() {
    super.initState();

    loginStatus();

    //loginStatus();
  }

  Future<void> loginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('idusuario') != null) {
      idusuariofinal = sharedPreferences.getString('idusuario');
      // print("existe el valor" + widget.idusuario);
      // print("Hay un valor ingresado en el homescreen y es " + idusuariofinal);
    }
  }

  String url3 = 'http://gestionaproyecto.com/phpappalimentos/getAlimentos.php';
  String url4 =
      'http://gestionaproyecto.com/phpappalimentos/getComidalogin.php';

  // ignore: missing_return

  Future<List> getAlimentos() async {
    if (idusuariofinal != null) {
      final response =
          await http.post(Uri.parse(url4), body: {'idusuario': idusuariofinal});
      return json.decode(response.body);
    } else {
      final response = await http.get(Uri.parse(url3));
      return json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loginStatus(),
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
            // appBar: AppBar(
            //   title: new Text("Recetas populares"),
            //   backgroundColor: Colors.black45,
            // ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: new FutureBuilder<List>(
                        future: getAlimentos(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? new Alimentosrecomendados(
                                  list: snapshot.data,
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
        });
  }
}

class Alimentosrecomendados extends StatefulWidget {
  final List list;

  const Alimentosrecomendados({Key key, this.list}) : super(key: key);
  @override
  _AlimentosrecomendadosState createState() => _AlimentosrecomendadosState();
}

class _AlimentosrecomendadosState extends State<Alimentosrecomendados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Recetas populares",
                style: TextStyle(fontSize: 25),
              )),
          Expanded(
            child: ListView.builder(
                itemCount: widget.list == null ? 0 : widget.list.length,
                itemBuilder: (context, i) {
                  return new Column(
                    children: <Widget>[
                      Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: Row(children: <Widget>[
                              GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new DetalleComida(
                                                  idcomida: widget.list[i]
                                                      ['idcomida'],
                                                  list: widget.list,
                                                  index: i,
                                                )),
                                      ),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        elevation: 10,
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: ClipRRect(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.20,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: new AssetImage(
                                                                    widget.list[
                                                                            i]
                                                                        ['rutaimagencomida'])))),
                                                    Expanded(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 2,
                                                                    right: 4,
                                                                    left: 4),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  widget.list[i]
                                                                      [
                                                                      'nombrecomida'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.06,
                                                                  child: Text(
                                                                    widget.list[
                                                                            i][
                                                                        'descripcioncomida'],
                                                                    maxLines: 3,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(widget
                                                                            .list[i]
                                                                        [
                                                                        'puntuacion']),
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))),
                            ])),
                      ]),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
