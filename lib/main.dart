import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/provider.dart';
import 'package:formularios_bloc/src/pages/homa_page.dart';
import 'package:formularios_bloc/src/pages/login_page.dart';
import 'package:formularios_bloc/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      count: (1),
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
