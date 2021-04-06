import 'package:flutter/material.dart';
import 'package:form_validator/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  // **Para que no se pierda la info cuando se refresque un widget
  static Provider _instancia;

  // Determina si se necesita regresar una nueva instancia de la clase
  // o utilizar la existente
  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  // Constructor interno
  Provider._internal({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  // Este bloque es el objeto a los que queremos acceder a través de la aplicación
  final loginBloc = LoginBloc();

  /// Este método se utiliza para acceder a una instancia de
  /// un widget heredado de la parte inferior del árbol.
  /// `.dependOnInheritedWidgetOfExactType` recorre todo el árbol
  static Provider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>());
  }

  @override
  bool updateShouldNotify(Provider oldWidget) => true;
}
