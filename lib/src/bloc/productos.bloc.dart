import 'dart:io';

import 'package:formularios_bloc/src/models/product_model.dart';
import 'package:formularios_bloc/src/services/productos.services.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc {
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productosServices = new ProductoService();

  Stream<List<ProductoModel>> get getProductosStream =>
      _productosController.stream;

  Stream<bool> get getCargando => _cargandoController.stream;

  void cargarPRoductos() async {
    final productos = await _productosServices.listarProductos();
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosServices.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    String fotoUrl = await _productosServices.subirImagen(foto);

    _cargandoController.sink.add(false);
    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosServices.actualizarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto(String id) async {
    await _productosServices.borrarProducto(id);
  }

  dispose() {
    _productosController.close();
    _cargandoController.close();
  }
}
