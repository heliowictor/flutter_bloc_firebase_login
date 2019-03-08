import 'package:bloc_firebase_login/bloc/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState loginState) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _loginBloc.dispatch(LoginEvent.loginWithGoogle);
                    },
                    color: Colors.white,
                    child: Container(
                      width: 230,
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text("Usuario Logado: ${loginState.token}"),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}