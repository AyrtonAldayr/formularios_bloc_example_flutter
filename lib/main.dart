import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/provider.dart';
import 'package:formularios_bloc/src/pages/homa_page.dart';
import 'package:formularios_bloc/src/pages/login_page.dart';
import 'package:formularios_bloc/src/pages/product_page.dart';
import 'package:formularios_bloc/src/pages/registro_page.dart';

void main() {
  // final prefs = new PreferenciasUsuario();
  //   await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      count: (1),
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductPage(),
          'registro': (BuildContext context) => RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
