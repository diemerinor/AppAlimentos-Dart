import 'package:flutter/material.dart';
import 'package:aplicacion_alimentos/src/homescreen.dart';
import 'package:aplicacion_alimentos/src/recomendados.dart';
import 'package:aplicacion_alimentos/src/Notificaciones.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'app.dart';

class Notificaciones extends StatefulWidget {
  @override
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  SharedPreferences sharedPreferences;
  String idusuario;

  TextEditingController controllerusuario = new TextEditingController();
  TextEditingController controllerpass = new TextEditingController();
  String mensaje = '';

  String url2 = 'http://gestionaproyecto.com/phpappalimentos/login.php';

  loginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('idusuario') != null) {
      idusuario = sharedPreferences.getString('idusuario');
      print("Hay un valor ingresado en notificaciones y es " + idusuario);
    } else {
      print("En notificaciones no hay valores");
    }
  }

  void initState() {
    super.initState();
    loginStatus();
  }

  String url = 'http://gestionaproyecto.com/phpappalimentos/getPerfil.php';

  getPerfil() async {
    final response =
        await http.post(Uri.parse(url), body: {'idusuario': idusuario});
    return json.decode(response.body);
  }

  cerrarsesion() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('idusuario');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  login() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(url2), body: {
      "nombreusuario": controllerusuario.text,
      "password": controllerpass.text
    });
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "Usuario o contraseña incorrecta";
      });
    }
    sharedPreferences.setString("idusuario", datauser[0]['idusuario']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  idusuario: datauser[0]['idusuario'],
                )));

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loginStatus(),
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
            body: ListView(
              children: [
                if (idusuario != null)
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: new BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(46, 12, 21, 20),
                                Color.fromRGBO(46, 12, 21, 10)
                              ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(this.context).size.height *
                                  0.30,
                              margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new RaisedButton(
                        child: new Text(
                          "Cerrar sesión",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          cerrarsesion();
                        },
                      ),
                    ],
                  )
                else if (idusuario == null)
                  SingleChildScrollView(
                    child: Form(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.only(top: 23),
                              child: ListView(children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5)
                                      ]),
                                  child: TextFormField(
                                    controller: controllerusuario,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.account_box,
                                          color: Colors.black,
                                        ),
                                        hintText:
                                            'Ingrese su correo o telefono'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5)
                                      ]),
                                  child: TextField(
                                    controller: controllerpass,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.vpn_key,
                                          color: Colors.black,
                                        ),
                                        hintText: 'Ingrese su contraseña'),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text('Olvidé mi contraseña',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17)))),
                                new RaisedButton(
                                  child: new Text("Ingresar"),
                                  color: Colors.yellow,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    login();
                                  },
                                ),
                                Text(mensaje,
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.red)),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  CircularProgressIndicator()
              ],
            ),
          );
        });
  }
}
