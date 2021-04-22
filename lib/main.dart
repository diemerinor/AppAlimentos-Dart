import 'dart:convert';

import 'package:aplicacion_alimentos/src/app.dart';
import 'package:aplicacion_alimentos/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'src/app.dart';
String idusuario;
void initState() {
  //loginStatus();
}

void main() {
  runApp(MyHomePage());
}



// class LoginApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Login',
//         home: LoginPage(),
//         routes: <String, WidgetBuilder>{
//           '/app': (BuildContext context) => MyHomePage(),
//           '/misproyectos': (BuildContext context) => MisProyectos(),
//           '/homescreen': (BuildContext context) => MyHomePage(),
//           '/LoginPage': (BuildContext context) => LoginPage(),
//         });
//   }
// }

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String url2 = 'http://gestionaproyecto.com/phpproyectotitulo/login.php';
//   TextEditingController controllerusuario = new TextEditingController();
//   TextEditingController controllerpass = new TextEditingController();

//   String mensaje = '';
//   String rol;

//   Future<List> login() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     final response = await http.post(Uri.parse(url2), body: {
//       "nombreusuario": "diego",
//       "password": "12345",
//     });

//     // if (sharedPreferences.getString("token") != null) {
//     //   MyHomePage();
//     // }

//     var datauser = json.decode(response.body);

//     if (datauser.length == 0) {
//       setState(() {
//         mensaje = "Usuario o contraseña incorrecta";
//       });
//     } else {
//       if (datauser[0]["codigorol"] == 1) {
//         rol = 'Admin';
//       }
//       Navigator.pop(context);

//       //Navigator.of(context).pushNamed('/app');
//       //Navigator.pushReplacementNamed(context, '/misproyectos');
//       setState(() {
//         username = datauser[0]['nombreusuario'];
//         idusuario = datauser[0]['idusuario'];
//         apellidos = datauser[0]['apellidos'];
//         telefono = datauser[0]['telefono'];
//         correousuario = datauser[0]['correousuario'];
//         acercademi = datauser[0]['acercademi'];
//         rutafotoperfil = datauser[0]['fotoperfil'];
//         //codigorol = datauser[0]['codigorol'];
//         sharedPreferences.setString("token", datauser[0]['idusuario']);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => MyHomePage(
//                     /*usuarionombre: username,
//                       idusuario: idusuario,*/
//                     )));
//       });
//     }
//     return datauser;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: new BoxDecoration(
//                 image: new DecorationImage(
//                     image: new AssetImage(
//                       "assets/images/fondologin3.jpg",
//                     ),
//                     fit: BoxFit.cover)),
//             child: ListView(
//               children: <Widget>[
//                 new Container(
//                   padding: EdgeInsets.only(top: 107),
//                   child: new CircleAvatar(
//                     backgroundColor: Colors.yellow,
//                   ),
//                   width: 245.0,
//                   height: 285.0,
//                   decoration: BoxDecoration(shape: BoxShape.circle),
//                 ),
//                 new Container(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   padding: EdgeInsets.only(top: 23),
//                   child: ListView(children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(color: Colors.black12, blurRadius: 5)
//                           ]),
//                       child: TextFormField(
//                         controller: controllerusuario,
//                         decoration: InputDecoration(
//                             icon: Icon(
//                               Icons.account_box,
//                               color: Colors.black,
//                             ),
//                             hintText: 'Ingrese su correo o telefono'),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       margin: EdgeInsets.only(top: 20),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(color: Colors.black12, blurRadius: 5)
//                           ]),
//                       child: TextField(
//                         controller: controllerpass,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             icon: Icon(
//                               Icons.vpn_key,
//                               color: Colors.black,
//                             ),
//                             hintText: 'Ingrese su contraseña'),
//                       ),
//                     ),
//                     Align(
//                         alignment: Alignment.center,
//                         child: Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Text('Olvidé mi contraseña',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 17)))),
//                     new RaisedButton(
//                       child: new Text("Ingresar"),
//                       color: Colors.yellow,
//                       shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(30.0)),
//                       onPressed: () {
//                         login();
//                       },
//                     ),
//                     Text(mensaje,
//                         style: TextStyle(fontSize: 25.0, color: Colors.red)),
//                   ]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
