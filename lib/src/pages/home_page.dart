import 'package:flutter/material.dart';
import 'package:form_validator/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Email: ${bloc.loginBloc.email}'),
            Divider(),
            Text('Password: ${bloc.loginBloc.password}'),
          ],
        ),
      ),
    );
  }
}
