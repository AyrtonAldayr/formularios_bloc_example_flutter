import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/models/product_model.dart';
import 'package:formularios_bloc/src/services/productos.services.dart';
import 'package:formularios_bloc/src/utils/utils.dart';

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
            onPressed: () {},
            icon: Icon(Icons.photo_size_select_actual),
          ),
          IconButton(
            onPressed: () {},
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

  void _submit(BuildContext context) {
    if (!fomrKey.currentState!.validate()) return;
    fomrKey.currentState!.save();
    // print(producto.titulo);
    // print(producto.valor);
    // print(producto.disponible);

    setState(() {
      _guardando = true;
    });

    if (producto.id == null) {
      productoNuevo.crearProducto(producto);
    } else {
      productoNuevo.actualizarProducto(producto);
    }

    // setState(() {
    //   _guardando = false;
    // });
    ScaffoldMessenger.of(context)
        .showSnackBar(mostrarSnackBac('Registro Guardado'));
    Navigator.pop(context);
  }

  SnackBar mostrarSnackBac(String mensaje) {
    return SnackBar(
      content: Text('$mensaje'),
      duration: Duration(milliseconds: 1500),
    );
  }
}
