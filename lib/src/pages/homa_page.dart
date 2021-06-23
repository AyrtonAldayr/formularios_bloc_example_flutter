import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Emeil: ${bloc.getEmail}'),
          Divider(),
          Text('Password: ${bloc.getPassword}'),
        ],
      ),
    );
  }
}
