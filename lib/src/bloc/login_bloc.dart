import 'dart:async';

import 'package:form_validator/src/bloc/validators.dart';
// RxJs
import 'package:rxdart/rxdart.dart';

// TODO Patron Bloc
class LoginBloc with Validators {
  // Controladores
  // **.broadcast() permite que escuche el controlador mas de una peticion
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  /// `.transform(StreamTransformer)`
  /// Pasa por el validador en Validators
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  // TODO RX Combina dos Observables
  // Valida los validadores del formulario
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) {
        if ((e == _emailController.value) && (p == _passwordController.value)) {
          return true;
        }
        return false;
      });

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  // Siempre se tiene que cerrar los Streams
  dispose() {
    // El ? es por si viene un valor nulo
    _emailController?.close();
    _passwordController?.close();
  }
}
