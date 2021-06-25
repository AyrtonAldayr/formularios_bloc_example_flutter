import 'dart:convert';

import 'package:formularios_bloc/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductoService {
  final String _url =
      'https://flutter-proyecto-formulario-default-rtdb.firebaseio.com/';

  Future<bool> crearProducto(ProductoModel producto) async {
    final response = await http.post(_convertUrl('productos'),
        body: productoModelToJson(producto));
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<bool> actualizarProducto(ProductoModel producto) async {
    final response = await http.put(_convertUrl('productos/${producto.id}'),
        body: productoModelToJson(producto));
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> listarProductos() async {
    final response = await http.get(_convertUrl('productos'));
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    if (decodedData.isEmpty) return [];
    decodedData.forEach((id, prod) {
      final productoTemp = ProductoModel.fromJson(prod);
      productoTemp.id = id;
      productos.add(productoTemp);
    });

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final response = await http.delete(_convertUrl('productos/$id'));
    print(response.body);
    return 1;
  }

  Uri _convertUrl(String valor) {
    return Uri.parse('$_url/$valor.json');
  }
}
