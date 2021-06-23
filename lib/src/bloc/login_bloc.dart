import 'dart:async';

import 'package:formularios_bloc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get fromValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  //Insertar valores al Stream
  Function(String) get changesEmail => _emailController.sink.add;
  Function(String) get changesPassword => _passwordController.sink.add;

  //Obtener los valores ingresados en los streams
  String get getEmail => _emailController.value;
  String get getPassword => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
