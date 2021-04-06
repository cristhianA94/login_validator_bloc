import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_validator/src/bloc/login_bloc.dart';
import 'package:form_validator/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
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

  Widget _loginForm(BuildContext context) {
    // TODO Bloc login
    final bloc = Provider.of(context).loginBloc;
    final size = MediaQuery.of(context).size;

    // Permite hacer scroll
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          // **Contenedor de botones
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  // Sombra inferior card
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Text('Ingresar', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                // Referencia al BlocLogin
                _crearEmail(bloc),
                SizedBox(height: 20.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc, context),
              ],
            ),
          ),
          Text('¿Olvidó su contraseña?'),
          SizedBox(height: 75.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    // Permite manejar datos asyncronos
    return StreamBuilder(
      // Stream del email
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black54),
            // toolbarOptions: ToolbarOptions(copy: false, selectAll: true),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.black54),
              icon: Icon(Icons.alternate_email, color: Colors.cyanAccent),
              hintText: 'ejemplo@email.com',
              labelText: 'Correo electrónico',
              // Permite ver el Stream del valor ingresado
              // counterText: snapshot.data,
              // Validador de email
              errorText: snapshot.error,
            ),
            // TODO Cursor INPUT
            cursorWidth: 3.0,
            cursorColor: Colors.cyan,
            cursorRadius: Radius.circular(5.0),
            // TODO Asigna el valor al bloc
            onChanged: (value) => bloc.changeEmail(value),
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              // Oculta el texto
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.cyan),
              // toolbarOptions: ToolbarOptions(copy: false, selectAll: true),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black54),
                icon: Icon(Icons.lock_open_outlined, color: Colors.cyanAccent),
                labelText: 'Contraseña',
                // Validador de contraseña
                errorText: snapshot.error,
              ),
              cursorWidth: 3.0,
              cursorColor: Colors.cyan,
              cursorRadius: Radius.circular(5.0),
              // Asigna valor al bloc
              onChanged: bloc.changePassword,
            ),
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Valida si hay data en los inputs
        bool btnEnabled = snapshot.data ?? false;

        return Container(
          child: ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                backgroundColor: MaterialStateProperty.all(Colors.cyan),
                overlayColor: MaterialStateProperty.all(Colors.tealAccent[400]),
                visualDensity: VisualDensity.compact),
            onPressed: btnEnabled ? () => _login(bloc, context) : null,
          ),
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    print('==================');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('==================');
    Navigator.pushReplacementNamed(context, 'home');
  }

  // Crea el fondo del login
  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoAzulDegradado = Container(
      // 40% de la pantalla
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.2, 0.8],
        colors: [
          Color.fromRGBO(0, 122, 223, 1.0),
          Color.fromRGBO(0, 236, 188, 1.0),
        ],
      )),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 235, 255, 0.15),
      ),
    );

    // Posiciones
    return Stack(
      children: [
        fondoAzulDegradado,
        Positioned(top: -40.0, left: -50.0, child: circulo),
        Positioned(top: 85.0, left: 50.0, child: circulo),
        Positioned(top: 250.0, left: -30.0, child: circulo),
        Positioned(bottom: 750.0, right: -10.0, child: circulo),
        Positioned(bottom: 520.0, right: 60.0, child: circulo),
        Center(
          child: Container(
            padding: EdgeInsets.only(top: 90.0),
            child: Column(
              children: [
                Icon(Icons.person_pin, size: 90.0, color: Colors.white),
                // SizedBox(height: 10.0),
                Text('¡Bienvenido!',
                    style: TextStyle(color: Colors.white, fontSize: 30.0))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
