import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/services/productos.services.dart';
// import 'package:formularios_bloc/src/bloc/provider.dart';
import 'package:formularios_bloc/src/models/product_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productoServices = new ProductoService();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListado(context),
      floatingActionButton: _crearBoton(context),
    );
  }

  FloatingActionButton _crearBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add),
    );
  }

  FutureBuilder<List<ProductoModel>> _crearListado(BuildContext context) {
    return FutureBuilder(
      future: productoServices.listarProductos(),
      initialData: [],
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) =>
                _crearIteams(context, snapshot.data![i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Dismissible _crearIteams(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.amber,
      ),
      onDismissed: (direction) {
        productoServices.borrarProducto(producto.id!);
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text('${producto.id}'),
        onTap: () =>
            Navigator.pushNamed(context, 'producto', arguments: producto),
      ),
    );
  }
}
