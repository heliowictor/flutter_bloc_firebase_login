import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/bloc/bloc_delegate.dart';
import 'package:bloc_firebase_login/common/common.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';
import 'package:bloc_firebase_login/bloc/authentication/authentication.dart';
import 'package:bloc_firebase_login/ui/home/home.dart';
import 'package:bloc_firebase_login/ui/login/login.dart';
import 'package:bloc_firebase_login/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  
  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }

            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }

            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: _userRepository);
            }

            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }

          },
        ),
      )
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
