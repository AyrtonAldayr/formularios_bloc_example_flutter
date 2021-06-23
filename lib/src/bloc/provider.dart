import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/login_bloc.dart';
export 'package:formularios_bloc/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBlock = LoginBloc();

  Provider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBlock;
  }
}
