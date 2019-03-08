import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/bloc/login/login.dart';
import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState, 
    LoginEvent event
  ) async* {
    UserRepository _userRepository = UserRepository();
    
    switch (event) {
      case LoginEvent.loginWithGoogle:
        try {
          final UserModel user = await _userRepository.authenticateWithCredentials(
            credentialType: CredentialType.GOOGLE
          );
          yield LoginState.success(user.token);
        } catch (error) {
          print(error);
          yield LoginState.failure(error);
        }
        break;
    }
  }
}