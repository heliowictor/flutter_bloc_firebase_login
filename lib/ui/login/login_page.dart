import 'package:bloc_firebase_login/bloc/authentication/authentication.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {

  final UserRepository userRepository;

  LoginPage({this.userRepository});

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: _authenticationBloc,
        builder: (BuildContext context, AuthenticationState authenticationState) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _authenticationBloc.dispatch(LoggedIn(authenticationType: AuthenticationType.GOOGLE));
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
                  
                ],
              ),
            ),
          );
        },
      )
    );
  }
}