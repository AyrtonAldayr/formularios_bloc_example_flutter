import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/provider.dart';
import 'package:formularios_bloc/src/services/productos.services.dart';
// import 'package:formularios_bloc/src/bloc/provider.dart';
import 'package:formularios_bloc/src/models/product_model.dart';

class HomePage extends StatelessWidget {
  final productoServices = new ProductoService();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    ProductosBloc productosBloc = Provider.productosBloc(context);
    productosBloc.cargarPRoductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListadoBloc(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  FloatingActionButton _crearBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
    );
  }

  // FutureBuilder<List<ProductoModel>> _crearListado(BuildContext context) {
  //   return FutureBuilder(
  //     future: productoServices.listarProductos(),
  //     initialData: [],
  //     builder:
  //         (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           itemCount: snapshot.data!.length,
  //           itemBuilder: (context, i) =>
  //               _crearIteams(context, snapshot.data![i]),
  //         );
  //       } else {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  StreamBuilder<List<ProductoModel>> _crearListadoBloc(ProductosBloc bloc) {
    return StreamBuilder(
      stream: bloc.getProductosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) =>
                _crearIteamsBloc(context, snapshot.data![i], bloc),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Dismissible _crearIteams(BuildContext context, ProductoModel producto) {
  //   return Dismissible(
  //     key: UniqueKey(),
  //     background: Container(
  //       color: Colors.amber,
  //     ),
  //     onDismissed: (direction) {
  //       productoServices.borrarProducto(producto.id!);
  //     },
  //     child: Card(
  //       child: Column(
  //         children: [
  //           (producto.fotoUrl == null || producto.fotoUrl!.isEmpty)
  //               ? Image(image: AssetImage('assets/no-image.png'))
  //               : FadeInImage(
  //                   placeholder: AssetImage('assets/jar-loading.gif'),
  //                   image: NetworkImage(producto.fotoUrl!),
  //                   height: 300.0,
  //                   width: double.infinity,
  //                   fit: BoxFit.cover,
  //                 ),
  //           ListTile(
  //             title: Text('${producto.titulo} - ${producto.valor}'),
  //             subtitle: Text('${producto.id}'),
  //             onTap: () =>
  //                 Navigator.pushNamed(context, 'producto', arguments: producto),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Dismissible _crearIteamsBloc(
      BuildContext context, ProductoModel producto, ProductosBloc bloc) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => bloc.borrarProducto(producto.id!),
      background: Container(
        color: Colors.amber,
      ),
      child: Card(
        child: Column(
          children: [
            (producto.fotoUrl == null || producto.fotoUrl!.isEmpty)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(producto.fotoUrl!),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text('${producto.id}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'producto', arguments: producto),
            ),
          ],
        ),
      ),
    );
  }
}
