import 'package:bloc_firebase_login/bloc/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _authenticationBloc.dispatch(LoggedOut()),
                    color: Colors.white,
                    child: Container(
                      width: 230,
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16
                            ),
                          )
                        ]
                      )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                  ),
                    
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: (authenticationState.userModel?.token != null) 
                      ? Text("Usuario Logado: ${authenticationState.userModel?.userName}")
                      : Container(),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
