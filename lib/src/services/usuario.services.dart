import 'dart:convert';

import 'package:formularios_bloc/src/preferencias_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  final String _firebaseToken = 'AIzaSyAxFKGMKGmW4w9A6DXfP4S1zqDf3QTYD4A';
  final _preferencias = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
      body: json.encode(authData),
    );
    Map<String, dynamic> decodedResp = json.decode(response.body);
    // print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _preferencias.setToken = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
      body: json.encode(authData),
    );
    Map<String, dynamic> decodedResp = json.decode(response.body);
    // print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _preferencias.setToken = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
