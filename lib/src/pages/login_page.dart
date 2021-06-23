import 'package:flutter/material.dart';
import 'package:formularios_bloc/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0),
        ]),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          // color: Colors.white
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    final loginCenter = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
          SizedBox(
            width: double.infinity,
            height: 10.0,
          ),
          Text(
            'Ayrton Aldayr Neves',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          )
        ],
      ),
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        loginCenter,
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 200.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 5.0)
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearBoton(bloc)
              ],
            ),
          ),
          Text('¿Olvido la contraseña?'),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              errorText: (snapshot.hasError ? snapshot.error.toString() : null),
              counterText: snapshot.data,
            ),
            onChanged: (value) => bloc.changesEmail(value.trim()),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                hintText: '**********',
                labelText: 'Contraseña',
                errorText:
                    (snapshot.error == null ? null : snapshot.error.toString()),
              ),
              onChanged: (value) => bloc.changesPassword(value.trim())),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.fromValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text(
                'Ingresar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              shadowColor: Colors.blueAccent,
            ),
            onPressed: snapshot.hasData ? () => _loginDto(bloc, context) : null,
          );
        });
  }

  _loginDto(LoginBloc bloc, BuildContext context) {
    print('============');
    print('Emeail: ${bloc.getEmail}');
    print('Password: ${bloc.getPassword}');
    print('============');

    Navigator.pushNamed(context, 'home');
  }
}
