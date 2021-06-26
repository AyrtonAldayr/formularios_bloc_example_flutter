import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/login_bloc.dart';
import 'package:formularios_bloc/src/bloc/productos.bloc.dart';
export 'package:formularios_bloc/src/bloc/login_bloc.dart';
export 'package:formularios_bloc/src/bloc/productos.bloc.dart';

class Provider extends InheritedWidget {
  final loginBlock = LoginBloc();
  final ProductosBloc _productosBlocPri = new ProductosBloc();
  final Widget child;
  final int count;

  Provider({Key? key, required this.child, required this.count})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return count == oldWidget.count;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBlock;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()!
        ._productosBlocPri;
  }
}
