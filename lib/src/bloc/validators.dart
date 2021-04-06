import 'dart:async';

class Validators {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    // Filtro para validar el email
    handleData: (email, sink) {
      // TODO Regex para email
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        // Deja fluir el email
        sink.add(email);
      } else {
        sink.addError('Email incorrecto');
      }
    },
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    // Filtro para validar la contraseña
    handleData: (password, sink) {
      if (password.length >= 6) {
        // Deja fluir la contrase
        sink.add(password);
      } else {
        sink.addError('Mínimo 6 caracteres');
      }
    },
  );
}
