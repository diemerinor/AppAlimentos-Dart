import 'dart:convert';
import 'dart:async';
import 'dart:io';

// import 'dart:html';

import 'package:aplicacion_alimentos/main.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_alimentos/src/homescreen.dart';
import 'package:aplicacion_alimentos/src/recomendados.dart';
import 'package:aplicacion_alimentos/src/Notificaciones.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final String idusuario;

  const MyHomePage({Key key, this.idusuario}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences sharedPreferences;

  int _selectedIndex = 1;

  void initState() {
    super.initState();
    //loginStatus();
    //loginStatus();
  }

  // loginStatus() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   print("hola");
  //   if (sharedPreferences.getString("idusuario") != null) {
  //     print("Si hay un valor y es ");
  //   } else {
  //     print("No hay un valor");
  //   }
  //   //   int identusuario;
  //   //    String valoraux = sharedPreferences.getString("token");
  //   //    identusuario = int.parse(valoraux);
  //   //    print(identusuario);
  //   //  }
  // }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    Recomendados(),
    Homescreen(
      idusuario: "1",
    ),
    Notificaciones(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextEditingController _controller;

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(46, 12, 21, 20),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => print('hi on menu icon'),
              );
            },
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(46, 12, 21, 20),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Recomendados',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Mi Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.white70,
          selectedItemColor: Color.fromRGBO(219, 10, 20, 100),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
