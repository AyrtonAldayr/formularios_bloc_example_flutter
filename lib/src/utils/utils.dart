import 'package:flutter/material.dart';

bool isNumeric(String s) {
  return s.isEmpty
      ? false
      : num.tryParse(s) == null
          ? false
          : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text('$mensaje'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
        ],
      );
    },
  );
}
