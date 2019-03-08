import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/bloc/bloc_delegate.dart';
import 'package:bloc_firebase_login/bloc/counter_bloc.dart';
import 'package:bloc_firebase_login/bloc/login/login.dart';
import 'package:bloc_firebase_login/bloc/theme_bloc.dart';
import 'package:bloc_firebase_login/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final CounterBloc _counterBloc = CounterBloc();
  final ThemeBloc _themeBloc = ThemeBloc();
  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CounterBloc>(bloc: _counterBloc),
        BlocProvider<ThemeBloc>(bloc: _themeBloc),
        BlocProvider<LoginBloc>(bloc: _loginBloc)
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeData theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: LoginPage(),
            theme: theme,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    _themeBloc.dispose();
    _loginBloc.dispose();
    super.dispose();
  }
}
