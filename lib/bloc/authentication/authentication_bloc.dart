import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/bloc/authentication/authentication.dart';
import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState, 
    AuthenticationEvent event
  ) async* {
    UserRepository _userRepository = UserRepository();
    
    if(event is AppStarted) {
      final UserModel userModel = await userRepository.currentUser();

      if (userModel != null)
        yield AuthenticationAuthenticated(userModel: userModel);
      else
        yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      try {
        final UserModel userModel = await _userRepository.authenticateWithCredentials(authenticationType: event.authenticationType);
        yield AuthenticationAuthenticated(userModel: userModel);
      } catch (error) {
        print(error);
      }
    }

    if (event is LoggedOut) {
      userRepository.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}