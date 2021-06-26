import 'dart:convert';
import 'dart:io';

import 'package:formularios_bloc/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart' as mime;

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

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dl33cmea0/image/upload?upload_preset=vkukesun');

    final mimeType = mime.mime(imagen.path)!.split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final repuesta = await http.Response.fromStream(streamResponse);

    if (repuesta.statusCode != 200 && repuesta.statusCode != 201) {
      return '';
    }
    final respData = json.decode(repuesta.body);
    return respData['secure_url'];
  }

  Uri _convertUrl(String valor) {
    return Uri.parse('$_url/$valor.json');
  }
}
