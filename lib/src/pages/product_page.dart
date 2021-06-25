import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/models/product_model.dart';
import 'package:formularios_bloc/src/services/productos.services.dart';
import 'package:formularios_bloc/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final fomrKey = GlobalKey<FormState>();
  final saffoldKey = GlobalKey<ScaffoldState>();
  final productoNuevo = new ProductoService();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  late File foto = new File("");

  @override
  Widget build(BuildContext context) {
    final arguments2 = ModalRoute.of(context)!.settings.arguments;

    if (arguments2 != null) {
      producto = arguments2 as ProductoModel;
    }

    return Scaffold(
      key: saffoldKey,
      appBar: AppBar(
        title: Text('Page producto'),
        actions: [
          IconButton(
            // onPressed: _seleccionarFoto(ImageSource.gallery),
            // onPressed: () => print('Seleccionar Foto'),
            onPressed: () => _procesarImagen(ImageSource.gallery),
            icon: Icon(Icons.photo_size_select_actual),
          ),
          IconButton(
            onPressed: () => _procesarImagen(ImageSource.camera),
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: fomrKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDiponible(),
                SizedBox(
                  height: 5.0,
                ),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (valor) => producto.titulo = valor!,
      validator: (valor) {
        if (valor!.length < 3) {
          return 'Ingrse el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (val) => producto.valor = double.parse(val!),
      validator: (val) {
        if (isNumeric(val!)) {
          return null;
        } else
          return 'Solo se permite numeros';
      },
    );
  }

  SwitchListTile _crearDiponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          producto.disponible = value;
        });
      },
    );
  }

  ElevatedButton _crearBoton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: (_guardando) ? null : () => _submit(context),
      icon: Icon(Icons.save),
      label: Text(
        'Guardar',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        shadowColor: Colors.blueAccent,
      ),
    );
  }

  SnackBar mostrarSnackBac(String mensaje) {
    return SnackBar(
      content: Text('$mensaje'),
      duration: Duration(milliseconds: 1500),
    );
  }

  _mostrarFoto() {
    if (producto.fotoUrl != null && producto.fotoUrl!.isNotEmpty) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(producto.fotoUrl!),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return _assetImage();
    }
  }

  Image _assetImage() {
    final url = foto.path;

    if (url.isNotEmpty) {
      return Image(
        image: FileImage(foto),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _procesarImagen(ImageSource origin) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: origin,
    );
    if (pickedFile != null) {
      foto = File(pickedFile.path);
    }
    if (foto.path.isNotEmpty) {
      print('Ingreso al foto.path.isNotEmpty');
      producto.fotoUrl = '';
    }
    setState(() {});
  }

  void _submit(BuildContext context) async {
    if (!fomrKey.currentState!.validate()) return;
    fomrKey.currentState!.save();
    setState(() {
      _guardando = true;
    });

    if (foto.path.isNotEmpty) {
      producto.fotoUrl = await productoNuevo.subirImagen(foto);
    }

    if (producto.id == null) {
      productoNuevo.crearProducto(producto);
    } else {
      productoNuevo.actualizarProducto(producto);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(mostrarSnackBac('Registro Guardado'));
    Navigator.pop(context);
  }
}
