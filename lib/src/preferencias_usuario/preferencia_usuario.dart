import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  SharedPreferences? _prefs;

  iniciarPreferencias() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //Getter y Setter del Token
  String get getToken {
    return this._prefs?.getString('Token') ?? '';
  }

  set setToken(String value) {
    this._prefs?.setString('Token', value);
  }

  //Getter y Setter de la ultima pagina
  String get getUltimaPagina {
    return this._prefs?.getString('ultimaPagina') ?? 'login';
  }

  set setUltimaPagina(String value) {
    this._prefs?.setString('ultimaPagina', value);
  }
}
